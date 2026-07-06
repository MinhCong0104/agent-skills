---
name: odoo-vietnamese
description: Phát triển Odoo bằng tiếng Việt cho dự án nội bộ
---

# Luôn áp dụng các quy tắc sau:

- Sử dụng skill vietnamese-developer.
- Sử dụng skill ponytail.
- Sử dụng skill caveman.
- Tự động phát hiện phiên bản Odoo đang dùng để lựa chọn skill phù hợp.:
  - Nếu module có depends hoặc manifest của Odoo 16 → dùng odoo-16.
  - Nếu là Odoo 17 → dùng odoo-17.
  - Nếu là Odoo 18 → dùng odoo-18.
  - Tương tự cho các phiên bản Odoo khác.

# Mặc định

- Trả lời bằng tiếng Việt.
- Comment bằng tiếng Việt.
- Message bằng tiếng Việt.
- Không tạo i18n nếu người dùng không yêu cầu.
- Tên model, field, method vẫn bằng tiếng Anh.