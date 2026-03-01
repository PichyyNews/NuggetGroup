# NuggetGroup Docker Infrastructure

โปรเจกต์นี้เป็นการตั้งค่าระบบ Infrastructure ด้วย Docker Compose สำหรับการรันระบบที่มีส่วนประกอบหลัก 3 ส่วน ได้แก่ Strapi App, PostgreSQL Database และ pgAdmin 

## โครงสร้างระบบ (Architecture)

ระบบถูกตั้งค่าการทำงานแยกตามไฟล์เพื่อให้ง่ายต่อการจัดการ โดยประกอบด้วย 3 เซอร์วิสหลัก:

- **`app.yaml` (s2app)**: แอปพลิเคชัน Strapi (Image: `prawee/strapi`) ทำหน้าที่เป็น Headless CMS สำหรับจัดการเนื้อหา
- **`db.yaml` (s2db)**: ฐานข้อมูล PostgreSQL (Image: `postgres:15-alpine`) สำหรับเก็บข้อมูลของระบบ Strapi
- **`admin.yaml` (s2admin)**: ระบบจัดการฐานข้อมูล pgAdmin (Image: `dpage/pgadmin4`) สำหรับดูแลและจัดการ PostgreSQL ผ่านหน้าเว็บ

## การเริ่มต้นใช้งาน (Getting Started)

### สิ่งที่ต้องมีเบื้องต้น
- Docker
- Docker Compose

### ขั้นตอนการรันระบบ

1. คัดลอกไฟล์กำหนดค่า Environment ตัวอย่างและสร้างเป็นไฟล์ `.env` (หากยังไม่มี):
   ```bash
   cp .env.example .env
   ```
   *หมายเหตุ: สามารถแก้ไขรหัสผ่านหรือตั้งค่าตัวแปรในไฟล์ `.env` ได้ตามความเหมาะสม*

2. รันคำสั่งต่อไปนี้เพื่อเริ่มต้นระบบทั้งหมด:
   ```bash
   docker compose up -d
   ```
   *ระบบมีการตั้งค่า `healthcheck` สำหรับฐานข้อมูล ดังนั้น App และ Admin จะรอจนกว่า Database พร้อมใช้งานอย่างสมบูรณ์ จึงหมดปัญหาข้อผิดพลาดการเชื่อมต่อระหว่างเริ่มต้น*

## การเข้าใช้งาน (Accessing the Services)

เมื่อระบบทำงานอย่างสมบูรณ์ สามารถเข้าถึงเซอร์วิสต่างๆ ได้ดังนี้:

- **Strapi Application**: [http://localhost:1337](http://localhost:1337)
- **Strapi Admin Panel**: [http://localhost:1337/admin](http://localhost:1337/admin)
- **pgAdmin Interface**: [http://localhost:5050](http://localhost:5050)

## ผู้จัดทำและผู้มีส่วนร่วม (Contributors)

| ชื่อ - นามสกุล | อีเมล | ความรับผิดชอบ |
| :--- | :--- | :--- |
| **พิชญุตย์ สมบุญ** | s6702041510113@email.kmutnb.ac.th | เป็น รีดเดอร์ (Leader) และดูแลภาพรวม |
| **อภิชาติ ถีเจริญ** | s6702041510211@email.kmutnb.ac.th | รับผิดชอบส่วนของ Admin (pgAdmin) |
| **ชวัลวิทย์ หมั่นถนอม** | ezmt011146@gmail.com | รับผิดชอบส่วนของ App (Strapi) |
| **ฐนิชา สวนวงค์** | s6702041510059@email.kmutnb.ac.th | รับผิดชอบส่วนของ Database (PostgreSQL) |

...
