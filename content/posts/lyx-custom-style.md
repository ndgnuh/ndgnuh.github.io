---
title: "Module trong Lyx"
date: 2021-09-07T00:00:00+07:00
summary: "Cách sử dụng và tạo module tuỳ chọn trong Lyx"
draft: true
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
- môi trường
- environment
- lyx style
- style
- paragraph
series:
- lyx
---

Mặc dù cung cấp rất nhiều các style hay gặp như itemize, enumerate... Lyx chắn chắc không bao phủ hết được những môi trường của Latex. Bài viết này sẽ giới thiệu, hướng dẫn sử dụng module và cuối cùng, cách tự tạo một *style* văn bản tuỳ chọn trong Lyx.

## Module

Trong Lyx, module là những thành phần cung cấp các tính năng như lớp văn bản (documentclass của Latex), style của các đoạn văn... Thực tế, sự tương tác của Lyx và Latex được định nghĩa toàn bộ trong module có sẵn (trên Unix, nằm tại `/usr/share/lyx/layout`) chứ không bị gán cứng khi lập trình. Cách module trong Lyx được liệt kê tại menu cài đặt của văn bản: `Document > Settings > Module`. 
