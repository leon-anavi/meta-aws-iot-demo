FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI += " \
            file://aws-iot-device-client.conf \
            file://override.conf \
            file://aws-environment.env \
"

do_install:append() {
    echo "AWS_CREDENTIALS_ENDPOINT=${AWS_CREDENTIALS_ENDPOINT}" >> ${WORKDIR}/aws-environment.env
    echo "AWSIOT_ENDPOINT=${AWSIOT_ENDPOINT}" >> ${WORKDIR}/aws-environment.env
    ln -s aws-iot-device-client ${D}/etc/.aws-iot-device-client
    install -m 644 ${WORKDIR}/aws-iot-device-client.conf ${D}/etc/aws-iot-device-client/
    install -m 644 ${WORKDIR}/aws-environment.env ${D}/etc/aws-iot-device-client/
    install -m 755 -d ${D}/etc/systemd/system/aws-iot-device-client.service.d/
    install -m 644 ${WORKDIR}/override.conf ${D}/etc/systemd/system/aws-iot-device-client.service.d/
}
