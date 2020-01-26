---
title: "Julia Dojo: cài đặt Julia"
date: 2020-01-25T21:36:08+07:00
draft: false
url: "/julia-dojo/cai-dat-julia"
summary: "Hướng dẫn tải và cài đặt Julia trên máy tính của bạn"
description: "Hướng dẫn tải và cài đặt Julia trên máy tính của bạn"
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
---

Chào mừng các bạn đến với bài viết đầu tiên của series "Julia từ con số không". Trong bài viết này mình sẽ hướng dẫn các bạn cách cài đặt Julia.
Để cài Julia, chúng ta có 2 cách:
- [Cài đặt từ bản phân phối chính thức](#cài-đặt-từ-bản-phân-phối-chính-thức): cách này được khuyến cáo vì nó sẽ không gây lỗi lặt vặt, tuy nhiên quá trình cài đặt sẽ hơi dài một chút.
- [Cài đặt từ bản phân phối của cộng đồng](#cài-đặt-bản-phân-phối-từ-cộng-đồng): cách này rất đơn giản, đặc biệt với những bạn dùng Linux. Tuy nhiên cách này có thể gây lỗi vặt (thực ra mình mới chỉ thấy một lỗi trên ArchLinux, chưa thấy có người gửi issue nào khác)

Mình sẽ hướng dẫn các bạn cả hai cách. Việc cài đặt có thể sử dụng tới terminal (dòng lệnh, hiểu nôm na là vậy), vậy có kiến thức cơ bản về việc sử dụng terminal và shell có thể sẽ hữu dụng và giúp quá trình cài đặt dễ dàng hơn. Nếu bạn không biết những thứ này cũng không nên lo quá.

## Cài đặt bản phân phối từ cộng đồng

Vì cách này ngắn và đơn giản hơn, mình sẽ hướng dẫn trước. Để thực hiện cách cài đặt này, bạn cần có package manager. Cái này trên *Nix thì có chắc chắn có sẵn, còn trên MacOS và Windows có lẽ bạn sẽ phải cài thêm. Khi xong xuôi, bạn chỉ cần mở terminal và ehạy lệnh tương ứng với hệ điều hành của mình:

{{<expand "Windows - Chocolately" >}}
Cài đặt:
```shell
choco install julia --confirm
```
Cập nhật:
```shell
choco upgrade julia --confirm
```
{{</expand >}}


{{<expand "MacOs - HomeBrew">}}
### HomeBrew trên Mac

```shell
brew cask install julia
```
{{</expand>}}

{{<expand "Fedora/Red hat/Cent OS và các distro tương tự">}}

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
{{</expand>}}

{{<expand "Debian/Ubuntu và các distro tương tự">}}
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
{{</expand>}}

{{<expand "Archlinux và các distro tương tự">}}
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
{{</expand>}}

## Cài đặt từ bản phân phối chính thức 

Việc cài đặt sẽ chia thành ba bước. Đầu tiên, bạn cần truy cập [trang tải về của Julia](https://julialang.org/downloads) để lấy bản phân phối chính thức. Mình sẽ hướng dẫn chi tiết quá trình cài đặt. Bước tiếp theo là giải nế và cài đặt. Cuối cùng, chúng ta sẽ cài đặt biến môi trường để có thể truy cập vào Julia mọi lúc mọi nơi.

### Tải Julia
{{< img src="/img/julia-install-download.png" caption="Trang download Julia" >}}

Julia cung cấp một số lựa chọn:
- Current stable release: phiên bản ổn định.
- Bản Release Candidate: phiên bản ứng cứ viên phát hành, có thể hiểu là "gần" ổn định..
- Long-term support: Phiên bản hỗ trợ lâu dài, bạn có thể hiểu đây là phiên bạn "cực kì ổn định".
- [Bản Nightly](https://julialang.org/downloads/nightlies/): Bản thử nghiệm, dành cho những thanh niên thích thử nghiệm.
  
Sau khi đã quyết định sẽ sử dụng phiên bản nào, hãy tải về bản cài đặt phù hợp với hệ điều hành của bạn. Ví dụ nếu mình dùng Windows 64 bit hãy tải file `Windows (.exe)` ở cột `64-bit` (trong ảnh).

### Giải nén và cài đặt

{{< expand Windows>}}
Sau khi tải Julia như trên, chúng ta sẽ có một file `.exe`. Mở file `exe` này lên. Việc cài đặt tương đối đơn giản, chỉ cần next, next và next. 

Lưu ý rằng, quá trình cài đặt có một bước chọn đường dẫn giải nén. Hãy lưu lại đường dẫn này để sử dụng ở bước sau.
{{< /expand >}}

{{< expand MacOS >}}
Sau khi tải Julia như trên, chúng ta sẽ có một file `.dmg`. Mở file `.dmg` ấy, bên trong có file `Julia-<phiên-bản>.app`. Kéo thả file này vào thư mục `Application` trên desktop của bạn và bạn đã hoàn thành bước này.
{{</ expand >}}

{{< expand "Linux, BSD, *Nix" >}}
Sau khi tải Julia như trên, chúng ta sẽ có một file `.tar.gz`. Hãy copy file này vào vị trí cài đặt tương ứng, sau đó giải nén file này ra bằng lệnh:
```shell
tar -xvf đường/dẫn/tới/<file-của-bạn>.tar.gz
```
Một vài file, thư mục mới sẽ xuất hiện, vậy là bạn đã hoàn thành bước này.
{{< /expand >}}

### Thêm đường dẫn đến Julia vào biến môi trường

Để có thể gọi Julia từ mọi nơi, bạn cần thêm đường dẫn tới file thực thi Julia vào biến `$PATH`. Tuy cả ba nhóm hệ điều hành trên đều dùng biến môi trường này, cách cài đặt sẽ khác nhau một chút.

{{< expand "Windows 10">}}
1. Nhấn tổ hợp phím `Windows + R`, gõ `sysdm.cpl` và nhấn `Enter`
2. Một cửa sổ hiện lên, hãy chọn thẻ `Advanced`, chọn `Environment Variables`.
3. Thêm một cửa sổ nữa hiện lên, trong phần `System variables`, chọn `Path` và click vào nút `Edit`
4. Một cửa sổ hiện ra, nhấn `New`. Một cửa sổ mới hiện ra với một hộp văn bản
5. Lấy đường dẫn cài đặt ở bước 2 ra, thêm `\bin` vào đuôi và copy vô cái hộp văn bản đó. Ví dụ mình cài Julia vào `E:\julia`, mình sẽ ghi `E:\julia\bin`.
6. Ấn `Ok`, tắt hết các hộp thoại, giờ bạn đã cài xong Julia.
{{< /expand >}}

{{< expand "Windows khác" >}}
1. Nhấn tổ hợp phím `Windows + R`, gõ `sysdm.cpl` và nhấn `Enter`
2. Một cửa sổ hiện lên, hãy chọn thẻ `Advanced`, chọn `Environment Variables`.
3. Thêm một cửa sổ nữa hiện lên, trong phần `System variables`, chọn `Path` và click vào nút `Edit`
4. Sau khi nhấn `Edit`, sẽ có một cửa sổ với 2 hộp văn bản xuất hiện.
5. Click vào hộp văn bản thứ 2 (`Variable value:`) và di chuyển đến cuối dòng, nếu cuối dòng không có dấu `;` hãy thêm dấu `;` vào.
6. Lấy đường dẫn cài đặt ở bước 2 ra, thêm `\bin` vào đuôi và **copy thêm vào cuối** của hộp văn bản thứ 2. Ví dụ mình cài Julia vào `E:\julia`, mình sẽ ghi thêm `E:\julia\bin` vào cuối. Nhắc lại rất kĩ là **ghi thêm** nhé, ông nào paste đè lên cái cũ xong hỏng máy tôi không chịu trách nhiệm đâu.
7. Ấn `Ok`, tắt hết các hộp thoại, giờ bạn đã cài xong Julia.
{{< /expand >}}

{{< expand MacOS >}}
1. Chạy `open -a TextEdit ~/.bash_profile` trên Terminal. Nếu bạn dùng `zsh` thì thay `.bash_profile` bằng `.zshrc` (nếu bạn không biết bạn đang dùng cái gì thì đừng để ý đoạn `zsh` này).
2. Lệnh trên sẽ mở file `~/.bash_profile` để bạn chỉnh sửa. Thêm dòng `export PATH="/Applications/Julia-.app/Contents/Resources/julia/bin:${PATH}"` vào cuối và save lại.
{{</ expand >}}

{{< expand "Linux, BSD, *Nix" >}}
Bạn có 3 lựa chọn như dưới đây, sau khi thực hiện một trong ba bạn sẽ có thể sử dụng Julia.
- Thêm thư mục Julia vào biến `$PATH` bằng cách thêm dòng lệnh mình ghi ở dưới vào trong file `~/.bashrc` và `~/.bash_profile`. Thay hai file trên với `~/.zshrc` nếu bạn dùng `zsh`. Thay những file trên với `/etc/profile`, `/etc/bash.bashrc` hoặc `/etc/zsh` nếu bạn muốn cài đặt trên toàn hệ thống.
```shell
export PATH="$PATH:/đường/dẫn/tới/<julia dir>/bin"
```
- Chạy lệnh `echo $PATH` xem biến `$PATH` của bạn có những thư mục nào, ví dụ mình sẽ chọn `/usr/bin`. Sau đó, hãy tạo liên kết tới Julia trong thư mục đó bằng lệnh `sudo ln -s /đường/dẫn/tới/<julia dir>/bin/julia /usr/bin/` (mình dùng `sudo` vì cần quyền ghi vào `/usr/bin`, nếu người dùng của bạn ghi được vào thư mục trên `$PATH` thì không cần `sudo`)
- Cách cục súc: bạn sẽ chạy `/đường/dẫn/tới/<julia dir>/bin/julia` mỗi lần bạn dùng đến nó.
{{< /expand >}}

### Lưu ý thêm cho những bạn dùng Windows

{{< expand "Nếu bạn dùng Windows 7" >}}
1. [bản update này](https://support.microsoft.com/en-us/help/3140245/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-wi) sẽ giúp trình quản lý gói của Julia hoạt động. Xuống phần `Method 2` và click vào link [Microsoft Update Catalog](https://support.microsoft.com/en-us/help/3140245/update-to-enable-tls-1-1-and-tls-1-2-as-default-secure-protocols-in-wi).
2. [Windows Management Framework 3.0 hoặc hơn](https://docs.microsoft.com/en-us/powershell/scripting/wmf/overview) để cài Powershell. Vào trang web trên, kéo xuống dưới cái bảng và click vào phiên bản bạn muốn download.
{{< /expand >}}

Nhìn chung, nếu bạn dùng Windows, mình khuyên các bạn nên tìm một terminal khác ngoài `cmd` và cái đi kèm với Powershell. Một số gợi ý cho các bạn:
- Terminal của [Visual Studio Code](https://code.visualstudio.com)
- [Git bash](https://gitforwindows.org)

## Tổng kết
Các bạn có thể cài đặt Julia theo cách mình muốn. Bản cài chính thức cài đặt sẽ dài dòng hơn một chút nhưng đảm bảo hơn, bản cài do cộng đồng phân phối sẽ tiện lợi hơn với một tỉ lệ rất rất nhỏ xảy ra bug. Để kiểm tra việc cài đặt Julia có thành công hay không, hãy mở Terminal và chạy lệnh `julia`. 
{{< img src="/img/julia-install-check.png" caption="Nếu lệnh chạy thành công, chúng ta sẽ thấy màn hình Julia chào đón mình">}}
