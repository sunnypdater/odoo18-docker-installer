# ใช้ Odoo official image แทน
FROM odoo:18.0

# ติดตั้ง dependencies สำหรับการคอมไพล์ MySQL client
USER root
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    default-libmysqlclient-dev \
    build-essential \
    libssl-dev \
    libffi-dev

# ติดตั้ง MySQL client library
#RUN pip3 install mysqlclient

# คัดลอกไฟล์ odoo.conf เข้าไปใน container
COPY ./config/odoo.conf /etc/odoo/odoo.conf
COPY ./addons /mnt/extra-addons

# เปลี่ยนกลับไปเป็น user odoo (ตาม Docker official image ของ Odoo)
USER root

# เปิด port 8069 (พอร์ตเริ่มต้นของ Odoo)
EXPOSE 8069 

# คำสั่งที่ใช้ในการรัน Odoo โดยใช้ odoo.conf
CMD ["odoo", "-c", "/etc/odoo/odoo.conf"]
