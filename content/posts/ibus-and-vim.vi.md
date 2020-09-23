---
title: "Gõ tiếng Việt và Vim"
date: 2020-04-26T15:42:24+07:00
lastmod: 2020-09-23T09:56:33+07:00
draft: false
summary: "Thuốc giảm đau cho việc gõ tiếng Việt với Vim"
categories:
- hướng dẫn
tags:
- linux
- foss
keywords:
- ubuntu
- linux
- foss
- mã nguồn mở
- tự do
- debian
- ibus
- gõ tiếng việt
- unikey
- vim
- vi
- neovim
---

Update: Đổi một số dòng code (đổi `silent` -> `silent!`) khi IBus không bật thì VIM sẽ không kêu gào mỗi lần vào/thoát normal mode.

Hello friend. Nếu bạn đã sử dụng bất kì hệ điều hành Unix based (Linux, BSD), bạn rất có thể đã gặp khá nhiều vấn đề trong việc gõ tiếng Việt. Đặc biệt nếu bạn gõ telex và những công cụ của bạn sử dụng phím tắt bàn phím như Vim.

# Vấn đề
Nếu bạn đang xem bài viết này, khả năng là bạn đã quen sử dụng Vim rồi nên mình cũng chẳng giới thiệu về Vim làm gì. Vấn đề chủ yếu mình gặp phải khi gõ tiếng Việt với Vim là:
- Chế độ Preedit (ibus-unikey) vốn rất khó chịu rồi, khi trong chế độ normal mà không tắt tiếng Việt thì sẽ luôn phải nhấn một phím nào đó để commit, thậm chí phải thêm 1 lần nhấn nữa để bỏ dấu
- Chế độ gõ không dùng preedit trong bọ gõ ibus-bamboo đã xử đẹp thằng unikey, tuy nhiên bạn vẫn phải nhấn thêm 1 lần nữa để bỏ dấu, ví dụ như thay cho `dd` thì bạn phải nhấn `ddd`, vì `dd` sẽ chỉ gửi chữ `đ` thẳng vào terminal của bạn (theo mình biết là vậy). Một số chế độ khác của Bamboo sửa được cái đó, nhưng việc gõ tiếng Việt trong chế độ đó lại bị lỗi.
- Terminal với nhập liệu bị trễ, mình gặp với alacritty.

Trong bài viết này, chúng ta sẽ bàn bạc cách xử lý những vấn đề trên

# Xử lý
Thực chất vấn đề với nhập liệu không phải vấn đề riêng của các bộ gõ tiếng Việt, nó là một vấn đề chung với người dùng Vim. Nhưng khi quan sát, bạn nhận ra rằng gõ tiếng Việt hoàn toàn vô dụng, thậm chí gây khó chịu khi bạn không ở trong insert mode của Vim. Để giải quyết vấn đề này chúng ta có thể dùng một trong ba cách dưới đây:

Cách 1 là không dùng IBus, dùng keymap của Vim. Nếu bạn dùng Neovim hay vì một lý do nào đó mà bạn không có file keymap thì có thể tải nó tại [thư mục nay](https://github.com/vim/vim/tree/master/runtime/keymap), copy thư mục config của Vim với đường dẫn `runtime/keymap/`. Và thêm dòng này trong config của bạn:
```VimL
" thay telex bằng VNI và VIQR
set keymap=vietnamese-telex
```

Cách này khá ổn nếu bạn phải làm việc qua ssh và server không có IBus. Tuy nhiên bạn sẽ phải gõ chính xác từng kí tự, nếu không thì nó sẽ không hoạt động (chữ `â` yêu cầu phải gõ 2 chữ `a` liên tiếp, `danga` sẽ không tạo ra `dâng`). Vì lí do đó, nếu bạn dùng cho mục đích cá nhân, mình recommend 2 cách ở dưới

Cách 2 là dùng [Vim barbaric](https://github.com/rlue/vim-barbaric). Đây là một plugin giúp bạn chuyển IBus về tiếng Anh khi bạn không ở trong insert mode. Nó được thiết kế để có thể hoạt động ngay khi cài xong. Chi cần thêm nó với trình quản lý gói Vim của bạn (Mình dùng Plug, nó khá đơn giản và nhẹ):
```VimL
Plug 'rlue/vim-barbaric'
```
Tuy nhiên, plugin này vẫn chưa thỏa mãn mình lắm.
1. Dùng 1 plugin để thực hiện chức năng như trên có vẻ hơi overkill (lí do khá
   chủ quan :v)
2. Khi vào search mode plugin không tự chuyển sang gõ tiếng Việt cho bạn

Vì hai lý do trên, mình viết một giải pháp gọn nhẹ của riêng mình - Cách 3 - autocmd và giao diện dòng lệnh của IBus. Đầu tiên chúng ta cần có tính năng tắt IBus và lưu engine mà chúng ta đang dùng lại. Chúng ta có thể dùng `ibus engine` để lấy ra tên của engine hiẹn tại và `ibus engine <tên engine>` để sử dụng một IBus engine:
```VimL
function! IBusOff()
	" Lưu engine hiện tại
	let g:ibus_prev_engine = system('ibus engine')
	" Chuyển sang engine tiếng Anh
	" Nếu bạn thấy cái cờ ở đây
	" khả năng là font của bạn đang render emoji lung tung...
	" xkb : us :: eng (không có dấu cách)
	silent! execute '!ibus engine xkb:us::eng'
endfunction
```

Tiếp theo chúng ta cài đặt tính năng để sử dụng lại engine đã được lưu:
```VimL
function! IBusOn()
	let l:current_engine = system('ibus engine')
	" nếu engine được set trong normal mode thì
	" lúc vào insert mode duùn luôn engine đó
	if l:current_engine !~? 'xkb:us::eng'
		let g:ibus_prev_engine = l:current_engine
	endif
	" Khôi phục lại engine
	silent! execute '!ibus engine ' . g:ibus_prev_engine
endfunction
```

Cuối cùng chúng ta cài autocmd để Vim tự động kích hoạt các tính năng trên:
```VimL
augroup IBusHandler
	" Khôi phục ibus engine khi tìm kiếm
	autocmd CmdLineEnter [/?] silent call IBusOn()
	autocmd CmdLineLeave [/?] silent call IBusOff()
	autocmd CmdLineEnter \? silent call IBusOn()
	autocmd CmdLineLeave \? silent call IBusOff()
	" Khôi phục ibus engine khi vào insert mode
	autocmd InsertEnter * silent call IBusOn()
	" Tắt ibus engine khi vào normal mode
	autocmd InsertLeave * silent call IBusOff()
augroup END
```

Cái này là tùy chọn, nhưng nếu bạn muốn IBus được tắt khi vào Vim, bạn có thể
thêm dòng sau:
```VimL
silent call IBusOff()
```

Chúng ta cần có `silent` để trong trường hợp IBus sập (IBus theo mình không ổn định lắm, rất hay lỗi...), Vim sẽ không ném một đống thứ linh tinh vào mặt bạn. Đương nhiên, giấu lỗi đi nghe không hay lắm, nhưng nếu dùng những thứ như `ps` và `grep` để kiểm tra thì CPU sẽ không chịu được nhiệt.

Ok, vậy chúng ta đã làm IBus hoạt động ngon lành trong Vim. Nhưng vẫn có vấn đề, một trường hợp hi hữu như sau: Bạn ở trong Normal Mode, bạn quay ra phần mềm khác (trình duyệt chẳng hạn), bật gõ tiếng Việt lên, và quay lại Vim.

Để xử lý vấn đề này, IBus có một tính năng là dùng input method riêng cho mỗi cửa sổ. Bạn chỉ cần chạy `ibus-setup`, chuyển sang tab `advanced`, bỏ dấu ở phần `share the same input method among applications`. Tuy nhiên, tính năng này theo mình không ổn định lắm. Có thể ở những phiên bản sau của IBus họ đã fix lỗi nên mình dùng chưa thấy sập hay gì, nhưng có những distro sử dụng mô hình stable release khiến cho việc update phần mềm có thể bị chậm.

Ngoài ra, nếu bạn dùng AwesomeWM bạn cũng có thể cài đặt một signal để nhận biết khi nào focus/unfocus cửa sổ có Vim để giải quyết vấn đề trên.

# Tổng kết

Gõ tiếng Việt với Vim:
- hoặc không dùng IBus, dùng Vim keymap
- tắt IBus khi thoát Insert Mode
   - Dùng plugin
   - Dùng code mình share ở trên
   - Tắt chế độ share input method của IBus

Vấn đề terminal bị trễ nhập liệu rất tiếc mình không xử lý được (nó là bug trên upstream của terminal). Cách xử lý đơn giản nhất là dùng 1 terminal khác. Một số gợi ý của mình (mình đã dùng qua và thấy gõ tiếng Việt OK):
- Termite (cái này hơi khó kiếm trên 1 số distro)
- URxvt
- QTerminal
- Xfce4-terminal

Gõ tiếng Việt vui vẻ.
