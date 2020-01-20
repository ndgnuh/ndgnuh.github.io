---
title: "Dùng Julia với Jupyter Notebook"
date: 2019-11-01T23:27:05+07:00
draft: true
summary: "Fun fact: tên Jupyter trong Project Jupyter là sự kết hợp của ba ngôn ngữ Julia, Python và R."
tags: 
- hướng dẫn
- julia
- lập trình
---

**Fun fact: tên Jupyter trong Project Jupyter là sự kết hợp của ba ngôn ngữ Julia, Python và R.**  (thông tin này là thật, các bạn có thể nhấn vào [link này](https://github.com/jupyter/design/wiki/Jupyter-Logo) trên để xác thực). Vì Jupyter hỗ trợ Julia chính thức nên việc sử dụng Julia với nó rất dễ dàng.

# Cài đặt

Yêu cầu: Jupyter đã được cài trước

> Hãy đọc hết hướng dẫn trước khi tiến hành

1. Đầu tiên bạn cần khởi động môi trường REPL Julia. Hãy mở một terminal, chạy lệnh `julia`. Trên Windows có thể dùng powershell và cmd.
2. Trên Julia REPL gõ `]`. Tới đây REPL sẽ chuyển sang chế độ package manager, nhấn `backspace` (nút xóa) để chuyển sang chế độ thường.
3. Chạy lệnh `add IJulia`
    - lệnh này sẽ cài gói `IJulia.jl` và cài một kernel jupyter
    - nếu bạn muốn dùng đường dẫn tùy chỉnh tới jupyter hoặc jupyter không nằm trong `$PATH` của bạn thì bạn có thể đặt đường dẫn đó bằng cách chạy lệnh `ENV["JUPYTER"] = "/đường/dẫn/tới/jupyter"` trong chế độ thường. Có thể kiểm tra xem Jupyter nằm trên `$PATH` hay không bằng cách chạy lệnh `jupyter` trên một terminal


<div align="center">
<img src="/img/cai-dat-ijulia-3.png" width=320/></br>
Nếu bạn cài thành công thì nó sẽ ra một đống info màu xanh lá. Thực chất mình cài rồi nên chạy lại nó chỉ update thôi.
</div>


# Sử dụng

Đầu tiên hãy chạy `jupyter notebook` để bắt đầu jupyter. sau đó nhấn vào new. Ở mục notebook chọn Julia, jupyter sẽ tạo một notebook mới với kernel Julia, tới đây các bạn dùng notebook này như bình thường, thử nghiệmcode, nghiên cứu này nọ :D

À đúng rồi, `IJulia.jl` hoạt động với cả jupyter notebook và cái jupyter lab xịn sò, nên nếu bạn nào làm việc với lab thì vẫn ok nhé!

Tham khảo thêm:

- [Trang github của IJulia](https://github.com/JuliaLang/IJulia.jl)
