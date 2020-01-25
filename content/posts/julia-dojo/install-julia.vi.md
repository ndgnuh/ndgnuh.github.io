---
title: "[Level 1] Cài đặt Julia"
date: 2020-01-25T14:52:52+07:00
draft: true
summary: "Hướng dẫn tải và cài đặt Julia trên máy tính của bạn"
tags:
- julia
---

Chào mừng các bạn đến với bài viết đầu tiên của series "Julia từ con số không". Trong bài viết này mình sẽ hướng dẫn các bạn cách cài đặt Julia.
Để cài Julia, chúng ta có 2 cách:
- [Cài đặt từ bản phân phối chính thức](#cài-đặt-từ-bản-phân-phối-chính-thức): cách này được khuyến cáo vì nó sẽ không gây lỗi lặt vặt, tuy nhiên quá trình cài đặt sẽ hơi dài một chút.
- [Cài đặt từ bản phân phối của cộng đồng](#cài-đặt-bản-phân-phối-từ-cộng-đồng): cách này rất đơn giản, đặc biệt với những bạn dùng Linux. Tuy nhiên cách này có thể gây lỗi vặt (thực ra mình mới chỉ thấy một lỗi trên ArchLinux, chưa thấy có người gửi issue nào khác)

Mình sẽ hướng dẫn các bạn cả hai cách. Việc cài đặt có thể sử dụng tới terminal (dòng lệnh, hiểu nôm na là vậy), vậy có kiến thức cơ bản về việc sử dụng terminal và shell có thể sẽ hữu dụng và giúp quá trình cài đặt dễ dàng hơn. Nếu bạn không biết những thứ này cũng không nên lo quá.

## Cài đặt bản phân phối từ cộng đồng

Vì cách này ngắn và đơn giản hơn, mình sẽ hướng dẫn trước. Để thực hiện cách cài đặt này, bạn cần có package manager. Cái này trên *Nix thì có chắc chắn có sẵn, còn trên MacOS và Windows có lẽ bạn sẽ phải cài thêm. Khi xong xuôi, bạn chỉ cần mở terminal và ehạy lệnh tương ứng với hệ điều hành của mình:

{{<expandmd "Windows - Chocolately" >}}
Cài đặt:
```shell
choco install julia --confirm
```
Cập nhật:
```shell
choco upgrade julia --confirm
```
{{</expandmd >}}


{{<expandmd "MacOs - HomeBrew">}}
### HomeBrew trên Mac

```shell
brew cask install julia
```
{{</expandmd>}}

{{<expandmd "Fedora/Red hat/Cent OS và các distro tương tự">}}

Với Fedora bản 19 hoặc hơn:
```shell
sudo dnf copr enable nalimilan/julia
sudo yum install julia
```

Nếu bạn dùng Cent OS bản 7 hoặc hơn:
```shell
sudo yum-config-manager –add-repo https://copr.fedorainfracloud.org/coprs/nalimilan/julia/repo/epel-7/nalimilan-julia-epel-7.repo
sudo yum install julia
```

Nếu `dnf` và `yum-config-manager` không khả dụng trên hệ thống của bạn, hãy tải file `.repo` tương ứng ở link phía trên và copy vào `/etc/yum.repos`, sau đó chạy câu lệnh thứ 2.

Để cập nhật Julia:
```shell
yum upgrade julia
```
{{</expandmd>}}

{{<expandmd "Debian/Ubuntu và các distro tương tự">}}
Cài đặt:
```shell
sudo apt update
sudo apt install julia
```
Cập nhật:
```shell
sudo apt update
sudo apt upgrade
```
{{</expandmd>}}

{{<expandmd "Archlinux và các distro tương tự">}}
Cài đặt:
```shell
sudo pacman -S julia # bản không chính thức
# những bản này cần `yay` để cài tự động
sudo yay -S julia-bin # tương ứng với bản chính thức từ trang chủ
yay -S julia-git # tương ứng vởi bản build từ git
```
Cập nhật:
```shell
sudo pacman -Syu
# hoặc
yay -Syu
```
{{</expandmd>}}

## Cài đặt từ bản phân phối chính thức 

Việc cài đặt sẽ chia thành ba bước. Đầu tiên, bạn cần truy cập [trang tải về của Julia](https://julialang.org/downloads) để lấy bản phân phối chính thức. Mình sẽ hướng dẫn chi tiết quá trình cài đặt. Bước tiếp theo là giải nế và cài đặt. Cuối cùng, chúng ta sẽ cài đặt biến môi trường để có thể truy cập vào Julia mọi lúc mọi nơi.

{{< expand Windows >}}
{{< /expand >}}

{{< expandmd MacOS >}}
*Phần này cần cần các bạn phản hồi, mình không có MacOS nên chưa kiểm thử.*
1.  Mở file `.dmg` bạn tải về, bên trong có file `Julia-<phiên-bản>.app`. Kéo thả file này vào thư mục `Application`.
2.   Nếu bạn cần chạy Julia từ terminal, chạy `open -a TextEdit ~/.bash_profile` (nếu dùng `zsh` thì thay `.bash_profile` bằng `.zshrc`)
3.   Thêm dòng `export PATH="/Applications/Julia-.app/Contents/Resources/julia/bin:${PATH}"` vào cuối và save lại
{{< /expandmd >}}

{{< expandmd "Linux/BSD/*nix" >}}
{{< /expandmd >}}

## Tổng kết
Các bạn có thể cài đặt Julia theo cách mình muốn. Bản cài chính thức cài đặt sẽ dài dòng hơn một chút nhưng đảm bảo hơn, bản cài do cộng đồng phân phối sẽ tiện lợi hơn với một tỉ lệ rất rất nhỏ xảy ra bug.

Sau khi cài đặt xong, để chạy script Julia, bạn chỉ cần chạy lệnh `julia đường-dẫn-đến-script.jl`. Ở phần tiếp theo mình sẽ nói đến một số công cụ có thể dùng để lập trình Julia. Bạn sẽ không cần chạy từng script như vậy mọi lúc nữa.
