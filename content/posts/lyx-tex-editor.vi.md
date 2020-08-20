---
title: "LyX: trình sửa văn bản WYSIWYM"
date: 2020-05-08T23:47:59+07:00
summary: "LyX - trình xử lý văn bản WYSIWYM  và front end cho LaTeX"
lastmod: 2020-05-18T20:11:32+07:00
draft: false
tags:
- linux
- foss
- lyx
- latex
- tex
keywords:
- lyx
- ubuntu
- linux
- foss
- mã nguồn mở
- tự do
series:
- lyx
---

# LyX là gì?

Trình xử lý văn bản LyX là sự kết hợp tuyệt vời giữa LaTeX và một giao diện đồ hoạ. Nếu bạn không biết LaTeX cũng đừng lo, dù kiến thức về LaTeX sẽ hữu dụng để dùng LyX, bạn không cần phải là một chuyên gia LaTeX để dùng LyX, thậm chí có thể vừa dùng LyX vừa học LaTeX. Thực tế, LyX có giao diện làm việc *hơi hơi* giống microsoft words (nhưng cách làm việc khác hoàn toàn nhé):

![](/img/lyx-01-first-look.png)

LyX sử dụng LaTeX làm backend và do đó hoạt động theo nguyên lý [What You See Is What You *Mean* (WYSIWYM)](https://en.wikipedia.org/wiki/WYSIWYM#Document_processors). Hiểu một cách đơn giản là các khối văn bản được "phân loại" tùy theo mục đích của chúng. Điều này - theo tôi - tốt hơn rất nhiều so với [What You See Is What You Get (WYSIWYG)](https://en.wikipedia.org/wiki/WYSIWYG) như MS Words, Libreoffice Writer và một số trình xử lý văn bản khác. Bài viết này sẽ giới thiệu sơ qua về cách cài đặt và sử dụng LyX.

# Cài đặt LyX

LyX là một phần mềm tự do mã nguồn mở giấy phép GPL-2.0. Điều đó có nghĩa rằng bạn có thể quyền sử dụng, sửa đổi và tái phân phối LyX mà không tốn một đồng nào mua bản quyền như những phần mềm thương mại. Để tải LyX hãy truy cập vào trang Web sau: https://www.lyx.org/Download sau đó chọn file cài đặt phù hợp với hệ điều hành của mình. Nếu dùng *Nix bạn có thể cài đặt qua trình quản lý gói của mình cho tiện.

*Lưu ý* rằng để sử dụng LyX bạn cần phải có một bản phân phối LaTeX đang hoạt động trên máy. Tôi khuyến cáo dùng TeXLive vì nó khá phổ biến nên dễ google lỗi hoặc những vấn đề về gói. Những bài viết này cũng sẽ sử dụng TeXLive. Bạn có thể tải nó [tại đây](https://www.tug.org/texlive/acquire-netinstall.html), hoặc dùng package manager để cài đặt.

Bạn cũng có thể sẽ cần phải cài thêm *Python 2* (việc nâng câp lên *Python 3* đang được thực hiện) và *Qt4.8* hoặc *Qt5.6*. Nếu bạn dùng package manager thì khả năng cao bạn không cần phải lo về việc này. Nếu bạn dùng bộ cài cho Windows hay Mac cũng đừng lo quá vì có thể hai cái này sẽ được bundle cùng với bộ cài. Nếu bạn vẫn gặp vấn đề thì hãy thử:
- cài đặt Python 2 trước
- nếu LyX vẫn không khởi chạy hãy cài Qt

# Sử dụng cơ bản

![Giao diện khi khởi chạy LyX](/img/lyx-01-first-run.png)

Mở LyX lên lần đầu tiên bạn sẽ nhận được giao diện như trong hình. Hãy nhấn `Ctrl + n` để tạo một file mới, hoặc `Ctrl + o` để mở một file có sẵn. Tôi sẽ giả định rằng bạn tạo một văn bản mới.
![](/img/lyx-01-hello-world.png)

Hãy gõ `hello world` và nhấn `Ctrl + r`. Nếu bạn cài đặt LyX đúng cách và có một trình xem pdf thì một file pdf hiện ra với dòng chữ "hello world".

![](/img/lyx-01-hello-world-pdf.png)

LyX đã đưa phần văn bản bạn nhập vào và tạo ra file pdf xem trước cho bạn, mà không cần những thứ khai báo lằng nhằng ở LaTeX. Giờ hãy quay lại LyX. đưa con trỏ tới cuối dòng và nhấn `Ctrl + m`. Bạn sẽ thấy một cái hộp nhỏ hiện ra, hãy gõ `\lim_n\to\infty x_n  ` (để ý dấu cách).

![](/img/lyx-01-simple-math.png)

Công thức toán hiện ra rất dễ nhìn trong hộp thoại. Đây cũng chính là một trong những điểm khác biệt của LyX so với những front-end khác của LaTeX. Không những công thức toán mà tất cả những lệnh trong môi trường toán của LaTeX đều được hỗ trợ (một số lệnh đặc biệt sẽ được dùng hơi khác). Tiếp theo hãy nhấn `Ctrl + Shift + r`, chuyển qua trình xem pdf lúc nãy và dùng refresh trình xem pdf của bạn (tôi không biết bạn dùng cái gì), bạn sẽ sẽ thấy file pdf được update (cách làm cho việc update xảy ra tự động sẽ nói sau).

![](/img/lyx-01-simple-math-pdf.png)

Giờ hãy quay lại LyX. Hãy nhấn `Ctrl + s` để lưu file của bạn lại. *Lưu ý rằng lưu file sẽ tạo ra file `lyx` thay vì file `pdf`*, nếu bạn muốn file pdf, hãy click vào `file > export` và chọn định dạng bạn mong muốn.

# Kết luận

Đây chỉ là một trong những cái nhìn đầu tiên về LyX (như một trình xử lý văn bản dễ dùng). Hiện tại chúng ta đã biết
- `Ctrl + n` tạo mới
- `Ctrl + o` mở văn bản LyX
- `Ctrl + s` lưu văn bản LyX
- `Ctrl + r` chế độ xem trước
- `Ctrl + Shift + r` update xem trước
- `file > export` xuất ra file pdf (hoặc định dạng khác)

Với LyX chúng ta sẽ có thể tạo ra những văn bản (mang tính kĩ thuật hoặc không) rất nhanh chóng và đẹp (báo cáo, viết sách, ghi bài, đồ án... làm được hết). Tuy nhiên tới đây bài viết cũng khá dài (và đây là một bài viết mang tính giới thiệu) nên những tính nay hay ho của LyX sẽ được trình bày trong những bài viết sau.

Edit: Nếu bạn thử gõ tiếng Việt và LyX báo lỗi thì đừng lo, đây là do LaTeX chứ không phải LyX. Việc gõ tiếng Việt hoàn toàn khả thi và rất dễ thôi, nhưng mình sẽ nói trong bài viết khác.

Edit: Để sử dụng đầy đủ những tính năng trong LyX, bạn cần có một số gói LaTeX như sau, hãy dùng lệnh ở dưới để cài chúng (mình sẽ cố lọc ra gói nào dùng cho việc gì ở bài viết sau):

```
tlmgr install algorithm2e algorithms apacite bbding bezos bibtopic
tlmgr install breakurl covington csquotes diagbox endnotes enumitem
tlmgr install epstopdf esint eurosym feyn fragments framed frankenstein
tlmgr install harvard hyphenat jurabib lettrine luainputenc marginnote
tlmgr install mathdesign mathdots mhchem multirow nicefrac nomencl
tlmgr install picinpar pict2e prettyref preview rotfloat rsfs shapepar
tlmgr install sidecap splitindex symbol tex-gyre ulem units wasy wasysym
tlmgr install wrapfig xargs
```
