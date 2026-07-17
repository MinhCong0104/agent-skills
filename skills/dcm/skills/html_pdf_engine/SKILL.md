---
name: html_pdf_engine
description: Kỹ năng xử lý, tạo và chỉnh sửa các mẫu (templates) HTML to PDF cho hệ thống Digital Certificate bằng WeasyPrint và Jinja2.
---

# Hướng dẫn sử dụng HTML PDF Engine

Kỹ năng này giúp Agent hiểu cách làm việc với công cụ tạo PDF từ HTML trong dự án.

## 1. Vị trí file quan trọng
- Core engine: `src/helpers/html_pdf_generator.py`
- Templates: `src/assets/html_templates/<template_id>/`
- Giới hạn render: `src/share/render_slot.py`

## 2. Cách tạo Template Mới
Khi có yêu cầu thêm một mẫu giấy chứng nhận PDF mới:
1. Tạo thư mục mới trong `src/assets/html_templates/`, ví dụ: `src/assets/html_templates/GCN_NEW_PRODUCT/`.
2. Tạo file `index.html` trong thư mục vừa tạo. Kế thừa template gốc nếu cần `{% extends "basic_template_gcn.html" %}`.
3. Tạo file `sample_data.json` chứa dữ liệu test mẫu khớp với các biến dùng trong template.
4. Đặt các tài sản CSS/Images dùng cho HTML trong thư mục đó.
5. Nếu có các điều khoản phụ lục dạng file PDF có sẵn, copy vào chung thư mục đó (ví dụ `merge.pdf`) và dùng cú pháp `{% merge './merge.pdf' %}` ở cuối file `index.html`.

## 3. Thay thế Text/Image trong file PDF Merge
Trong trường hợp file PDF template không thể convert ra HTML mà bắt buộc phải chèn chữ hoặc ảnh lên file PDF cứng (phụ lục, form có sẵn), bạn sử dụng tính năng của `MergePDFExtension`:
- Cú pháp replace text: `{% merge './merge.pdf', replace={'[Hovaten]': customer_name, '[Ngaysinh]': customer_dob} %}`
  - Trong ví dụ này, `[Hovaten]` là chữ có sẵn trên file `merge.pdf` (được ẩn đi) và engine sẽ in đè biến `customer_name` lên đúng vị trí đó.
- Cú pháp insert image: `{% merge './merge.pdf', insert_image={'[Signature]': {'data': base64_image_string, 'size': '100x50'}} %}`

## 4. Xử lý Font và Rendering
- Môi trường WeasyPrint render dựa trên CSS chuẩn.
- Các font mặc định được cung cấp trong `src/assets/fonts/`.
- Khi chèn text lên PDF bằng PyMuPDF (`replace` trong thẻ merge), hệ thống đã thiết lập font Unicode để hỗ trợ tiếng Việt (xem `_resolve_unicode_font`). Không cần phải lo lắng về lỗi font nếu sử dụng đúng cơ chế.

## 5. Quy tắc thực thi
- **Luôn kiểm tra biến trong file mẫu**: Biến trong `.html` phải đồng nhất với key trong file `sample_data.json`.
- Khi Agent được yêu cầu tạo/sửa HTML Template, hãy đọc kỹ `index.html` của các template khác làm ví dụ (như `GCN_NNX/index.html`).
