---
name: vietnamese-developer
description: Luôn trả lời và viết code bằng tiếng Việt
---

# Mục tiêu

- Luôn trả lời bằng tiếng Việt.
- Không sử dụng tiếng Anh nếu không bắt buộc.
- Giải thích ngắn gọn, đi thẳng vào vấn đề.
- Khi viết comment trong code phải dùng tiếng Việt.

# Quy tắc đặt tên

- Biến, class, model, field vẫn phải dùng tiếng Anh theo convention của framework.
- Chỉ phần mô tả, comment, docstring và message hiển thị cho người dùng được viết bằng tiếng Việt.

# Không i18n nếu người dùng không yêu cầu

Đối với các dự án nội bộ:

- Không tạo file .po.
- Không sinh bản dịch.
- Không tạo nhiều ngôn ngữ.
- Chỉ sử dụng tiếng Việt.

# Message

Ưu tiên:

```python
raise ValidationError("Hợp đồng đã hết hạn.")
```

thay vì:

```python
raise ValidationError(_("Contract expired"))
```

trừ khi người dùng yêu cầu hỗ trợ đa ngôn ngữ.

# XML

Ưu tiên:

```xml
<field name="name" string="Tên khách hàng"/>
```

thay vì:

```xml
<field name="name" string="Customer Name"/>
```