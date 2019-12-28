---
title: "Tương tác với Julia qua REPL"
date: 2019-12-08T23:37:39+07:00
summary: "Giới thiệu về việc sử dụng chế độ tương tác với Julia (Julia REPL)"
draft: true
---

#### Mục lục
- [REPL là gì?](#repl-l-g)
- [Sử dụng cơ bản](#s-dng-c-bn)
- [Các chế độ làm việc](#cc-ch--lm-vic)
- Những tính năng hay ho và độc nhất khác :)

## REPL là gì?

REPL là viết tắt của Read - Eval - Print - Loop, hay Đọc - Thực Thi - In Kết Quả - Lặp Lại. Nói một cách dễ hiểu, bạn nhập một dòng lệnh vào, Julia sẽ thực thi dòng lệnh đó, in ra kết quả và quá trình này lặp đi lặp lại đến khi bạn chán thì dừng.

Có thể bạn đã gặp REPL trước đây rồi, vì kha khá ngôn ngữ có tính năng này, những REPL khá phổ biến là Python hoặc console Javascript trên trình duyệt. Trong khi REPL như IPython có vẻ rất "ngon ăn" với những tính năng cần thiết như tự điền, stack trace, một số REPL khác dùng rất sida và thậm chí gây khó chịu (theo trải nhiệm của mình).

Rất may là: Julia không phải một trong những ngôn ngữ đó. Julia được ship với chế độ REPL built-in và thực sự nó **rất ngon** :)

## Sử dụng cơ bản

Để mở REPL có 2 cách:
- Click vào biểu tượng Julia (easy mà)
- Vào terminal/cmd, chạy `julia` (chỉ thực hiện được nếu đã cài biến môi trường)

Và để thoát ra thì chỉ cần gõ `exit()` và ấn enter. Về cơ bản thì đây là cách để bạn chạy một đoạn code. Ngoài ra nếu không nhớ tên đầy đủ của cái gì đó thì bạn có thể ấn tab để REPL tự điền tên hàm, biến, bla bla cho bạn (tab completion).

Sử dụng rất ez đúng không :) Nhưng nãy giờ chưa thấy có gì đặc sắc cả???

## Các chế độ làm việc

Trước khi nói đến đoạn `Tại sao nó ngon? Nãy giờ có thấy gì đâu? Ông chém gió à?`, mình sẽ phải nói về các chế độ vi của REPL trước, có thể nó hơi khác với các REPL khác ở điểm này. Đừng lo, bạn không phải học cái này cái nọ hay thay đổi cách làm việc đâu, chỉ là REPL của Julia chia thành các `chế độ`, và mỗi chế độ sẽ phục vụ một tính năng và có hành vi khác nhau, chỉ có vậy thôi.

Thông não trước khi đọc:
- Khi mình nói REPL, bạn cứ hiểu là Julia REPL nhé, viết dài ngại =))
- Hành vi sẽ bao gồm các tính năng nhé :v

#### Hành vi chung của tất cả các chế độ

#### Chế độ "tiêu chuẩn"

Đây là chế độ mặc định trên REPL, bạn nhập một `đoạn code` vào và ấn enter thì nó sẽ chạy. 


**Help**: đây là một tính năng cực kì hữu dụng
