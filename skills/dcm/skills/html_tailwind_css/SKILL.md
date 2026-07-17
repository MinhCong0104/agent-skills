---
name: html_tailwind_css
description: Hướng dẫn sử dụng TailwindCSS để tạo và biên dịch CSS cho các mẫu (templates) HTML trong dự án.
---

# Hướng dẫn sử dụng TailwindCSS cho HTML Templates

Dự án này sử dụng TailwindCSS để thiết kế giao diện cho các HTML Templates (như các form, chứng nhận, v.v.). Khi bạn được yêu cầu chỉnh sửa hoặc tạo giao diện HTML sử dụng Tailwind, hãy tuân theo quy trình sau.

## 1. Cấu trúc thư mục
Mỗi template (ví dụ `src/assets/html_templates/GCN_NEW_PRODUCT/`) có thể chứa:
- `index.html`: File HTML chính sử dụng các class của Tailwind.
- `tailwind.input.css` (Tùy chọn): File CSS đầu vào nếu bạn cần custom các layer `@apply` hoặc cấu hình thêm.
- `tailwind.config.js` (Tùy chọn): File cấu hình Tailwind riêng cho template này. Nếu không có, dự án sẽ dùng config mặc định ở root.
- `style.css`: File output sau khi build Tailwind. (File này tự sinh, KHÔNG chỉnh sửa trực tiếp).

## 2. Quy trình làm việc với TailwindCSS

### Bước 1: Viết HTML
Bạn viết HTML và sử dụng trực tiếp các class của Tailwind trong file `index.html`. Ví dụ:
```html
<div class="flex items-center justify-between p-4 bg-gray-100 rounded-lg">
    <h1 class="text-xl font-bold text-tasco-blue">Tiêu đề</h1>
</div>
```
Hãy chắc chắn rằng trong file `index.html`, bạn đã link tới file `style.css` sinh ra:
```html
<link rel="stylesheet" href="./style.css">
```

### Bước 2: Tuỳ chỉnh CSS hoặc Config (Nếu cần)
- Nếu cần viết thêm custom CSS bằng Tailwind (như `@apply`), hãy tạo file `tailwind.input.css` trong thư mục template.
- Nếu cần thêm các màu, font đặc thù cho template này, copy file `tailwind.config.template.js` từ root vào thư mục template thành `tailwind.config.js` và chỉnh sửa.

### Bước 3: Build CSS (Bắt buộc)
Mỗi khi bạn tạo mới, hoặc thay đổi bất kỳ class Tailwind nào trong `index.html`, bạn **BẮT BUỘC** phải chạy script build để Tailwind quét các class và sinh ra file `style.css`. 

**Lệnh chạy Terminal:**
```bash
python ./script/build_tailwind_css.py -t <tên_thư_mục_template>
```
*Ví dụ:*
```bash
python ./script/build_tailwind_css.py -t GCN_GC_ATVD
```

Lệnh này sẽ gọi `npx tailwindcss` và tự động biên dịch toàn bộ class bạn vừa dùng thành file `style.css` (minified) lưu tại thư mục template tương ứng.

## 3. Lưu ý quan trọng
- **Không bao giờ sửa trực tiếp `style.css`**: File này được sinh tự động. Bất kỳ thay đổi nào cũng sẽ bị ghi đè.
- **Màu sắc mặc định của Tasco**: Hãy xem trong file `tailwind.config.template.js` ở thư mục root để biết các biến màu có sẵn (ví dụ: `tasco-blue`, `tasco-red`, v.v.).
