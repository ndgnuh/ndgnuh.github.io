---
title: "Julia Dojo: Julia + Project Jupyter"
date: 2020-02-01T23:28:52+07:00
draft: false
url: "/julia-dojo/dung-julia-voi-jupyter-notebook-va-jupyter-lab"
summary: "Hướng dẫn cấu hình Julia để sử dụng với Jupyter Notebook và Jupyter Lab"
description: "Hướng dẫn cấu hình Julia để sử dụng với Jupyter Notebook và Jupyter Lab"
lastmod: 2020-01-31T13:46:21+07:00
categories:
- hướng dẫn
- lập trình
tags:
- julia
series:
- Julia Dojo
keywords:
- julia
- lập trình
- học lập trình
- ngôn ngữ julia
- julia dojo
- julialang
- hướng dẫn
- hướng dẫn lập trình Julia
- julia jupyter
- jupyter notebook
- jupyter lab
---

Chào mừng mọi người quay trở lại Julia Dojo. Trong bài trước chúng ta đã học về trình quản lí gói và cách để sử dụng các gói. Hôm nay, chúng ta sẽ thực hành cài đặt và sử dụng gói đầu tiên, cũng chính là gói mà hỗ trợ chúng ta làm việc với Jupyter Notebook. 

{{< notice info >}}
Có thể bạn chưa biết, tên của project Jupyter thực ra được tạo thành từ ba ngôn ngữ: Julia, Python và R. Dù không phải viết tắt trực tiếp của ba ngôn ngữ nhưng cái tên này đã cho thấy rất rõ ràng định hướng của project.
{{< /notice >}}

## Cấu hình & cài đặt

Trước khi cấu hình Julia để làm việc với Jupyter, chúng ta cần có Python hoặc Jupyter notebook/lab cài đặt sẵn trong máy (Python là phụ thuộc của Jupyter). Sau đó chúng ta tiến hành cài gói Julia. Mình sẽ không hướng dẫn cài đặt Python ở đây, rất nhiều hướng dẫn khác đã tồn tại trên mạng.

Sau khi thỏa mãn mọi điều kiện, bạn mở REPL và cài đặt gói `IJulia`.
```julia
]add IJulia
```

Nếu các bạn không quen với Jupyter (thường được biết đến với Jupyter Notebook), mình sẽ giải thích một cách ngắn gọn: Jupyter là một giao diện hơi giống REPL trên nền web dành cho các ngôn ngữ lập trình. Jupyter khác REPL ở chỗ, nó lưu lại lệnh và ghi chú của bạn. Để Jupyter hoạt động được, chúng ta cần có một thứ gọi là "nhân" của ngôn ngữ lập trình. Quy trình làm việc như sau:

1. Jupyter nhận input của bạn
2. Jupyter sẽ gửi code đến nhân
3. Nhiệm vụ của nhân là chạy đoạn code đó, sau đó gửi output tới Jupyter
4. Jupyter hiện output cho bạn

Gói `IJulia` chính là "nhân" dành cho ngôn ngữ Julia. Sau khi cài gói xong, chúng ta cần chạy lần đầu để Julia cài đặt nhân và cấu hình Jupyter để sử dụng nó. Bạn không cần lo về việc cài Jupyter, khi chạy IJulia lần đầu, Julia sẽ cài đặt Jupyter cho chúng ta nếu cần.
```julia
using IJulia
notebook() # để dùng Jupyter Notebook
jupyterlab() # để dùng Jupyter Lab
```

## Sử dụng

Chúng ta có thể sử dụng Julia với Jupyter theo cách ở trên, tuy nhiên, Jupyter sẽ dùng thư mục mà chúng ta dùng đang mở (thư mục mà chúng ta dùng để chạy Julia). Sau khi cấu hình với lần chạy đầu tiên của IJulia, chúng ta sẽ không cần mở REPL lên để dùng notebook nữa. Thay vào đó, chúng ta hãy mở một terminal tại thư mục bạn muốn. Ví dụ, mình dùng `notebook`:
```shell
cd notebook
jupyter notebook
# hoặc bạn muốn dùng jupyter lab
jupyter lab
```

Mình chỉ hướng dẫn notebook thôi, lab bạn tự tìm hiểu nhé. Sau khi chạy lệnh trên, một cửa sổ trình duyệt sẽ hiện lên:
{{< img src="/img/ijulia-guide-001.png" caption="Giao diện Jupyter Notebook" >}}

Để tạo một notebook, hãy ấn vào nút `New` ở góc phải màn hình. Sau đó một danh sách các nhân đã cài sẽ hiện lên, ở đây mình có hơi nhiều :)

{{< img src="/img/ijulia-guide-002.png" caption="Menu tạo notebook mới" >}}

Click vào `Julia x.y.z` để tạo một notebook sử dụng Julia, một cửa sổ khác sẽ hiện lên.

{{< img src="/img/ijulia-guide-003.png" caption="Giao diện của một notebook" >}}

Trong cửa sổ này, chúng ta có thể thêm, sửa, xóa, chạy các ô code hoặc nhấn phím `m` để chuyển qua viết ghi chú. Phím `y` dùng để chuyển lại một ô thành code và tổ hợp `Ctrl/Shift + Enter` dùng để chạy ô code đó.

{{< img src="/img/ijulia-guide-004.png" caption="Chạy code Julia, viết Markdown và LaTeX" >}}

## Tạm kết

Qua bài viết lần này, chúng ta đã biết cách cấu hình Julia để sử dụng với Jupyter Notebook. Những phần còn lại của giao diện notebook mời các bạn tự khám phá thêm, mình xin kết thúc bài viết này ở đây, tạm biệt và hẹn gặp lại các bạn trong những bài viết sau.

Tham khảo:
- https://github.com/JuliaLang/IJulia.jl
- https://jupyter.org/install
