---
name: html-templates
description: Làm việc với các template HTML bảo hiểm DCM trong src/assets/html_templates, bao gồm file Jinja index.html, sample_data.json, style.css, page CSS, font và Tailwind CSS khi template có dùng. Dùng khi chỉnh sửa, tạo mới, review hoặc debug HTML template, thư mục template GCN/GYC, field template, layout PDF/in ấn hoặc CSS riêng cho từng template.
---

# DCM HTML Templates

## Phạm Vi

Dùng skill này cho các công việc trong `src/assets/html_templates`, đặc biệt là các thư mục template như `GCN_*` và `GYC_*`.

Mỗi thư mục template thường có:

- `index.html`: nội dung Jinja template.
- `style.css`: CSS được viết tay hoặc được generate cho template.
- `sample_data.json`: dữ liệu render mẫu cho các field được dùng trong template.
- `tailwind.input.css`: input Tailwind tùy chọn, chỉ có ở template dùng Tailwind.
- `tailwind.config.js`: cấu hình Tailwind riêng cho template, chỉ thêm khi cần.
- `fields.md`: tài liệu field tùy chọn cho template phức tạp.

Các file dùng chung nằm trực tiếp trong `src/assets/html_templates`:

- `basic_template_gcn.html` và `basic_template_gyc.html` cung cấp layout Jinja nền.
- `fonts.css` định nghĩa font Tasco và font dự phòng dùng chung.
- `page.css` định nghĩa helper cho trang in/PDF.
- `html_templates_manager.html` là màn hình quản lý template trên browser.

## Quy Trình Làm Việc

1. Đọc thư mục template mục tiêu trước khi sửa. Khi chưa chắc, so sánh với các template cùng prefix, ví dụ `GCN_*` với các template `GCN_*` khác.
2. Giữ thay đổi trong phạm vi thư mục template mục tiêu, trừ khi yêu cầu nhắc rõ đến file base dùng chung.
3. Giữ đúng cú pháp Jinja và cách đặt tên field hiện có. Với giá trị hiển thị không bắt buộc, ưu tiên `|default('', true)` nếu template xung quanh đã dùng pattern đó.
4. Nếu thêm hoặc đổi tên field dữ liệu, cập nhật `sample_data.json` trong cùng thư mục để khớp với template.
5. Tailwind không phải lúc nào cũng được dùng. Nếu thư mục chỉ có `style.css`, sửa trực tiếp `style.css`. Nếu CSS được generate từ Tailwind, sửa `tailwind.input.css` hoặc `tailwind.config.js`, sau đó rebuild `style.css`; không sửa tay CSS minified đã generate.
6. Sau các thay đổi đáng kể, kiểm tra linter cho những file đã sửa nếu có thể.

## Tạo Template Mới

Ưu tiên dùng script generator hiện có:

```bash
./script/generate_html_base.sh --name TEMPLATE_FOLDER --base gcn
./script/generate_html_base.sh --name TEMPLATE_FOLDER --base gyc
```

Dùng `gcn` cho template extend `basic_template_gcn.html`; dùng `gyc` cho template extend `basic_template_gyc.html`.

Sau khi generate:

- Điền nội dung Jinja vào `index.html`.
- Điền `sample_data.json` với đầy đủ các field được dùng trong template.
- Không mặc định thêm Tailwind. Chỉ thêm `tailwind.input.css` và `tailwind.config.js` khi template thật sự cần Tailwind utilities hoặc mở rộng theme.
- Chỉ đặt asset local trong thư mục template khi asset đó riêng cho template; nếu đã có font/image dùng chung thì ưu tiên dùng lại.

## Quy Ước Jinja Template

- Đặt nội dung trang trong `{% block content %}`.
- Đặt link CSS của template trong `{% block extra_css %}` và thường include `<link rel="stylesheet" href="./style.css">`.
- Dùng base template với `{% extends "basic_template_gcn.html" %}` hoặc `{% extends "basic_template_gyc.html" %}`.
- Khi dùng custom filter `date`, bọc phần format date bằng guard:

```jinja
{% if 'date' is filter %}
{% set sign_date = sign_date|date("Ngày %d tháng %m năm %Y") %}
{% else %}
{% set sign_date = sign_date %}
{% endif %}
```

- Với checkbox, dùng đúng pattern class hiện có:

```jinja
<span class="checkbox {% if field == 'value' %}checked{% endif %}"></span>
```

## Styling Và Layout In/PDF

- Template phục vụ tài liệu bảo hiểm tiếng Việt và layout in/PDF. Ưu tiên `pt`, `mm` và rule trang A4 hơn các pattern responsive chỉ dành cho browser.
- Giữ thứ tự font fallback: `TascoDisplay`, `DejaVu Sans`, `Noto Sans CJK`, rồi generic sans-serif.
- Khi có thể, dùng màu Tasco dùng chung: deep blue `#292169`, teal `#68ccc7` hoặc `#52ccc6`, light teal `#caedec`, red `#ee1d23`.
- Dùng `break-inside: avoid` / `page-break-inside: avoid` cho các section không được tách qua trang.
- Cẩn thận với `overflow: hidden` trên trang in; nhiều template hiện dùng `height: auto` và `overflow: visible` để phân trang ổn định hơn.

## CSS Và Tailwind

Mặc định kiểm tra thư mục template trước:

- Nếu chỉ có `style.css`, coi đây là CSS nguồn và sửa trực tiếp.
- Nếu có `tailwind.input.css` hoặc `tailwind.config.js`, coi `style.css` là output build và sửa source Tailwind.

Build một template có Tailwind:

```bash
./script/build_tailwind_css.sh -t TEMPLATE_FOLDER
```

Build tất cả template có `tailwind.config.js`:

```bash
./script/pre_run_tailwind_templates.sh
```

Cấu hình Tailwind riêng của template nên dùng content path local:

```js
content: ['./**/*.html', './**/*.js']
```

Khi thư mục có `tailwind.input.css`, build script sẽ ghi output vào `style.css` trong chính thư mục đó. Không chạy build Tailwind cho template không dùng Tailwind trừ khi người dùng yêu cầu.

## Checklist Review

- `index.html` extend đúng base template.
- `style.css` được link từ template; nếu template dùng Tailwind thì đã rebuild sau khi source Tailwind thay đổi.
- `sample_data.json` là JSON hợp lệ và có giá trị thực tế cho mọi field được tham chiếu.
- Các field Jinja không bắt buộc sẽ không render ra `None`, `null` hoặc date lỗi trong tài liệu.
- Layout in vẫn dùng CSS có ý thức về A4/page và tránh page break không mong muốn.
- Không sửa file dùng chung cho nhu cầu riêng lẻ của một template.
