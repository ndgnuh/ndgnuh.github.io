---
title: "Julia từ con số không: Jupyter Notebook ♡ Julia"
date: 2020-01-24T23:27:05+07:00
draft: false
summary: "Fun fact: tên Jupyter trong Project Jupyter là sự kết hợp của ba ngôn ngữ Julia, Python và R."
tags: 
- hướng dẫn
- julia
- lập trình
---

> The three original programming languages that worked in Jupyter’s software were Julia, Python and R. While the name “Jupyter” is not a direct acronym for these languages, it nods its head in their directions. In particular, the “py” in the middle of Jupyter was chosen to honor our Python heritag
> - Jupyter Brand Guide - https://github.com/jupyter/design

Ba ngôn ngữ lập trình chính được cài đặt trong phần mềm của Jupyter là Julia, Python và R. Dù cái tên `Jupyter` không phải tên viết tắt trực tiếp, nó vẫn mang tính gợi về về ba ngôn ngữ này. Đương nhiên, vì thiết kế cốt lõi của Jupyter bao gồm cả Julia, việc sử dụng Jupyter Notebook hay Jupyter Lab với Julia tương đối dễ dàng. 

## Cài đặt

Nếu bạn đã cài đặt Jupyter, hãy skip đến phần [Cài đặt IJulia](#cài-đặt-ijulia)

### Cài đặt Jupyter
Để cài đặt được Jupyter thì trước hết cần có `python` cài đặt trong máy. Mình sẽ không hướng dẫn cài Python ở đây, các bạn chịu khó Google vì cài đặt nó cũng khá dễ. Sau khi cài đặt Python xong, các bạn có thể cài Jupyter theo hai câu lệnh sau:

```shell
# nếu bạn muốn dùng jupyter lab
pip install --user jupyterlab
# nếu bạn muốn dùng jupyter notebook
pip install --user notebook
```

{{< notice note >}}
Nếu bạn muốn cài đặt cho toàn bộ người dùng trên hệ thống của mình, hãy bỏ chữ `--user` trong hai câu lệnh trên. Lưu ý rằng, việc này sẽ cần quyền quản trị viên trên máy (người dùng `root` hoặc quyền sử dụng `sudo` trên Linux, hay lựa chọn `Run as Administrator` trên Windows).

Ngoài ra nếu trình quản lí gói của các bạn có cung cung cấp, các bạn có thể cài từ đó cho tiện cũng được
{{</notice >}}

Thực chất, Jupyter chỉ cung cấp giao diện để bạn làm việc. Để Jupyter notebook thực sự hoạt động, bạn sẽ cần một thứ gọi là "nhân" (kernel). Mỗi ngôn ngữ lập trình sẽ có một nhân riêng (Ví dụ như Python 3 Kernel), thậm chí có nhân sẽ dịch được nhiều ngôn ngữ lập trình. Khi hoạt động Jupyter sẽ đưa mã nguồn mà bạn nhập vào cho kernel, kernel sẽ dịch mã nguồn của ngôn ngữ mà nó phụ trách, đưa kết quả lại cho Jupyter, cuối cùng thì Jupyter hiển thị kết quả cho bạn.

### Cài đặt IJulia

IJulia chính là nhân Jupyter dành cho ngôn ngữ Julia, giúp các bạn có thể dùng Julia với Jupyter notebook hoặc Jupyter lab. Thực chất IJulia là một *gói* ở trong Julia. Để cài đặt nó, các bạn hãy mở [REPL](../julia-repl) lên, nhấn `]` để vào chế độ package manager. Mình sẽ nói chi tiết về việc quản lý gói trên Julia sau, hiện tại các bạn cứ chạy lệnh sau (trong chế độ package manager) để cài `IJulia`.
```julia
add IJulia
```

IJulia sẽ được cài đặt cùng với những gói phụ thuộc cần thiết. Nếu các bạn cài đặt thành công nó sẽ ra rất nhiều chữ màu xanh lá như trong hình. Thực chất mình đã cài IJulia từ trước rồi nên phần mềm quản lí gói chỉ check lại và update một số gói phụ thuộc thôi.

{{<img src="/img/cai-dat-ijulia-3.png" caption="Kết quả khi lệnh add IJulia thành công" width="320px">}}


## Sử dụng

Đầu tiên hãy chạy `jupyter notebook` để bắt đầu jupyter. sau đó nhấn vào new. Ở mục notebook chọn Julia, jupyter sẽ tạo một notebook mới với kernel Julia.

{{<img src="/img/ijulia-su-dung-001.png" caption="Tạo một notebook mới" >}}

Sau khi tạo xong notebook, bạn có thể mở notebook đó lên bằng cách nhấp đúp vào nó. Jupyter có các ô để bạn nhập code Julia vào, bạn có thể nhấn tổ hợp phím `Ctrl + Enter` để chạy ô code đó.

{{<img src="/img/ijulia-su-dung-002.png" caption="Sử dụng Julia với Jupyter notebook">}}

Ngoài ra, bạn có thể chạy Jupyter bằng cách mở REPL trong thư mục chứa những file notebook, sau đó chạy lệnh sau:
```julia
using IJulia
IJulia.notebook()
```

## Tổng kết

Khi mục đích là tìm hiểu, nghiên cứu hay thử nghiệm, Jupyter notebook hay Jupyter lab là công cụ tuyệt vời cho các bạn. Nếu các bạn gặp vấn đề hay bất kì thắc mắc gì, hãy liên hệ mình qua email `ndgnuh@protonmail.com`, để lại một issue trên [github](https://github.com/ndgnuh/ndgnuh.github.io) hoặc tham khảo thêm tại những trang web sau:

- [Trang github của IJulia](https://github.com/JuliaLang/IJulia.jl)
- [Trang chủ của Project Jupyter](https://jupyter.org/install)
