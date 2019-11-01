---
title: "[Hướng dẫn] Cài đặt ngôn ngữ Julia"
date: 2019-11-01T22:18:00+07:00
draft: false
description: "Cách tải và cài đặt Julia"
tags: 
- hướng dẫn
- julia
- lập trình
---

Cách tải và cài đặt ngôn ngữ Julia.

### Tải Julia về máy

Việc tải và cài đặt Julia rất đơn giản, bạn chỉ cần tải bản phân phối tương ứng với hệ điều hành của mình Julia tại https://julialang.org/downloads. Có ba lựa chọn cơ bản cho bạn tải:

- *Current stable release*: là phiên bản ổn định hiện tại
- *Long term support*: là phiên bản hỗ trợ lâu dài, hiểu nôm na nó là bản *rất ổn định*
- *Upcoming release*: là ứng cử viên phiên bản cho phiên bản ổn định sắp tới

Bạn nào ngại đọc tiếng Anh thì có thể đọc hướng dẫn từng-bước ở đây:

1. Truy cập trang https://julialang.org/downloads
2. Tìm đề mục tương ứng với những lựa chọn ở trên (Current stable release, Long term support,...)
3. Chọn file tương ứng với hệ điều hành của mình:
    - chọn phiên bản 32-bit \& 64-bit tương ứng
    - nếu dùng windows thì chọn  `windows (.exe)`
    - nếu dùng MacOS thì chọn  `MacOS 10.8+ (.dmg)`
    - nếu bạn dùng Linux hay FreeBSD thì mình nghĩ các bạn cũng không đọc đến phần này :) nhưng nêú bạn đọc đến đây mà không biết chọn gì thì *khả năng rất cao* là bạn nên chọn  `Generic Linux/FreeBSD Binaries for x86`
    - chọn bản 32-bit hoặc 64-bit tương ứng máy bạn

Nếu bạn là một người thích chơi ở mức khó, bạn có thể thử bản Nightly tại [đây](https://julialang.org/downloads/nightlies.html) nếu bạn thích tùy chỉnh thì có thể tự compile Julia, mã nguồn có trong [trang download](https://julialang.org/downloads) và cả trên [github](https://github.com/JuliaLang/julia/releases)

### Lưu ý riêng với những bạn dùng *Nix (Linux, BSD, ...)

- Nếu bạn không dùng những hệ điều hành này có thể nhảy tới phần sau
- Nếu bạn biết package manager hoạt động như thế nào, và cài đặt môi trường ra sao thì có thể bạn cũng không cần đọc phần này.

Có thể package manager của các bạn (`apt`, `pacman`, `xbps`,..) có phân phối Julia trong repo. Nếu vậy bạn hoàn toàn có thể dùng package manager để cài đặt, tiện quá rồi (*duh!*). Tuy nhiên, mình vẫn khuyên các bạn nên sử dụng bản phân phối chính thức trên trang web của Julia. Lí do là có những gói Julia trong package manager **không** phải là bản build chính thức (tức là họ tự build Julia rồi phân phối cho bạn), và có 2 vấn đề đi kèm việc đó:

- Bản Julia này có thể nó sẽ gây lỗi, ví dụ như lỗi build `Arpack.jl` trên ArchLinux (*thực ra lỗi build Arpack này là lỗi duy nhất mình biết, nếu bạn không gặp lỗi này thì chắc có thể cho qua được ._.*)
- Update chậm hơn release: cái này còn tùy vào người bảo trì cái repo cho distro bạn dùng. Nếu đội dev Julia tung ra bản mới mà ông bảo trì repo lười thì mới cũng như cũ :P

Tuy nhiên, với những gói mà chứa y nguyên bản Julia trên trang chủ thì bạn cài gói đó cho tiện :) ví dụ như `julia-bin` trong AUR của ArchLinux. Còn nếu bạn quyết định cài từ bản binary từ trang chủ thì bạn có thể làm theo hướng dẫn ở [đây](moi-truong-linux) để cài đặt môi trường.

### Editor và IDE
Bạn có thể theo dõi https://github.com/JuliaEditorSupport để xem hiện tại có những Text editor và IDE nào hỗ trợ Julia. Mình sẽ kể tên một số plugin thông dụng dưới đây:

- VSCode
- Sublime
- Atom (plugin Julia của editor này cực kì đủ tính năng, và cũng nặng nhất luôn)

Hoặc nếu bạn là một thanh niên bài trừ `electron.js` giống mình:

- Vim
- Emacs
- Notepad++
- IntelliJ

Ngoài ra bạn có thể dùng Jupyter notebook với Julia một cách dễ dàng. Xem hướng dẫn tại [đây](dung-julia-voi-jupyter-notebook)

