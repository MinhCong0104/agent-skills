# Global Rules cho Dự án DCM

## Xử lý HTML-to-PDF
- **Engine**: Ứng dụng dùng `weasyprint`, `Jinja2` và `PyMuPDF` nằm trong `src/helpers/html_pdf_generator.py`.
- Khi cần tạo một mẫu giấy chứng nhận (Certificate) mới, luôn tạo một thư mục mới trong `src/assets/html_templates/`.
- **Cấu trúc thư mục Template**: Một template phải chứa `index.html` và `sample_data.json` để phục vụ việc test/render preview.
- **Ghép trang PDF (Merge)**: Tránh dùng weasyprint để render những trang tĩnh phức tạp không cần thiết. Thay vào đó, sử dụng thẻ `{% merge 'file.pdf' %}` của Jinja2 để ghép các PDF tĩnh vào tài liệu động. Nếu cần thay thông tin trên PDF tĩnh, truyền tham số `replace` hoặc `insert_image` vào thẻ `merge`.
- **Performance**: Việc render PDF tốn tài nguyên. Nếu code gọi hàm render PDF, luôn cần cân nhắc nó đang chạy trong thread-pool và được quản lý slot thông qua `run_with_render_slot` (trong `src/share/render_slot.py`).
