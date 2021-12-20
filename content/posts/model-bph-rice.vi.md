---
title: "Phát triển, tối ưu và thử nghiệm một mô hình tác tử"
date: 2021-11-09T23:33:33+07:00
summary: "Câu truyện về tăng tốc một mô hình tác tử, khiến nó chạy nhanh gấp 1000 lần, phát triển mở rộng làm nó chậm đi, rồi lại tăng tốc tiếp..."
draft: true
categories:
tags:
- Julia
- ABM
- xàm
keywords:
- julia
- abm
- agents.jl
- gama platform
---

Bài viết mang tính kể chuyện và đi kèm một ít yếu tố kỹ thuật. Những ai chỉ quan tâm tới phần tối ưu mô hình mà không quan tâm tới câu truyện có thể nhảy tới cuối.


## Mở đầu
Câu chuyện kể về một sinh viên ngành "toán" tên X ở trường [----], khi X bắt đầu vào năm thứ tư. Dù học ba năm đại học, X vẫn không biết học xong ra trường làm việc gì. Do đó, dù đã lựa chọn đề tài làm đồ án, X vẫn đi hóng hớt mấy thanh niên cùng lớp xem chúng nó có làm gì hay ho, khiến X hứng thú hay không.

> Những sinh viên cùng khoá với X được làm hai đồ án. Đây là đồ án thứ nhất.

Sau một vài tuần lượn lờ, X gặp được một nhóm nghiên cứu nhỏ thông qua anh bạn cùng lớp Y. Nhóm này nghiên cứu chủ yếu về mô hình và mô phỏng. Giảng viên hướng dẫn của nhóm là cô Z. Cô Z giao cho các sinh viên của mình bài toán *mô phỏng sự tương tác giữa lúa và rầy nâu* (rầy nâu là mấy con côn trùng lúc nhúc, sống ký sinh và khá nguy hiểm cho lúa).

Bài toán này gồm hai hướng thực hiện. Hướng tiếp cận thứ nhất, phương trình, sử dụng hệ các phương trình vi phân để mô tả ở mức tổng quát những thành phần như số lượng lúa, số lượng rầy nâu, etc. và cách chúng tương tác với nhau. Hướng này đang được Y nghiên cứu. X thì nghe tới phương trình vi phân là rén rồi. Hướng tiếp cận số hai, tác tử (Agent Based Model, ABM), lập trình các phần mềm đại diện cho (nhóm) cá thể lúa và rầy nâu, cho chúng tương tác với nhau và theo dõi kết quả. Hướng tiếp cận này được thực hiện bởi anh T và một chị khác trong đội và sử dụng một bộ công cụ tên là *Gama*. Cô Z nghĩ X có khả năng lập trình khá ổn, muốn X tham gia để giúp đỡ việc chạy thí nghiệm & xử lý số liệu. X thấy cái này... cũng hay hay, gật đầu lia lịa.

> X nhìn cái gì cũng thấy hay hay.

## Bắt đầu với ABM

Khi X vào nhóm, mô hình thực ra đã được xây dựng bởi hai anh chị làm cùng rồi. Đó là một mô hình khá đơn giản:
- Không gian là một mặt phẳng thể hiện môi trường ruộng được chia thành các ô. Thời gian được chia thành bước.
- Một đám rầy xuất hiện, ăn cây lúa, đi ngẫu nhiên sang những ô bên cạnh, sinh sản
- Các phần tử trong mô hình thì có "HP" (đương nhiên trong tài liệu thật không gọi như thế này, nhưng gọi như thế này này quen thuộc hơn). Lúa nhận HP mỗi bước, mất HP khi rầy ăn, rầy nhận HP khi ăn lúa. HP về không thì chết.
- Trên "bản đồ" có một vùng trồng hoa, ngăn giữa các phần trồng lúa, rầy đi vào đây thì bị mất HP (kiểu như damage over time trong mấy trò chơi điện tử).
- Mục đích của mô hình là quan sát xem trồng hoa với khoảng cách như thế nào thì khi xuất hiện rầy, hoa có thể ngăn ngừa việc bay màu cả thửa ruộng.

> Nhưng có mô hình rồi thì X có cái gì để làm?

Mô hình như trên lập trình không hề khó, đặc bíệt dễ hơn khi có thêm công cụ chuyên dụng. Thậm chí, Gama còn cung cấp sẵn cả những thứ như giao diện đồ hoạ, đồ thị, xuất ra số liệu, etc. Tuy nhiên, một mô hình tác tử có một số đặc điểm khiến cho việc thí nghiệm với nó khá mệt mỏi.
1. Với mục đích như trên, thử nghiệm phải có nhiều kịch bản để đảm bảo tính tổng quát.
2. Mô hình muốn mô phỏng những tương tác chi tiết, nên sẽ có các yếu tốt ngẫu nhiên. X cần quan sát và phân tích số liệu đầu ra của một đống các thao tác ngẫu nhiên, thống kê là không thể tránh khỏi. Muốn thống kê thì X phải chạy mô phỏng nhiều lần.

Mô hình hiện tại chạy một lần mất 10 phút. Bỏ qua những chi tiết không liên quan, X cài đặt được một hệ thống để chạy tự động những mô hình này, tự thu tập kết quả và chỉ tốn một click để thực thi. Cô Z liền trưng dụng phòng lab của Viện để chạy mô phỏng hàng loạt. 

> Gọi "lab" cho oai thôi chứ thực ra là đó phòng máy tính cho sinh viên thực hành. Phòng toàn máy tính chạy Windows 7 với cầu hình tàng tàng. Có máy còn bị sinh viên làm cho dính virus hoặc dính những lỗi lặt vặt của Windows (có những lỗi khá vớ vẩn như Windows không mở được file Python dù đã cài PATH đúng cách, tìm ba trang Google không có cách sửa).

Đợt đó, nhóm chạy khoảng 128000 mô phỏng, thực chất chỉ có 64000 lần lấy kết quả do mô hình có sửa đổi cần chạy lại. Do máy tính chạy Windows và cấu hình mạng cũng không ổn định, việc truyền file sử dụng... USB. Mỗi lần chạy thử nghiệm mất 2-3 tiếng để cài đặt (copy mã nguồn và file cấu hình tới từng máy), khoảng nữa ngày để chạy mô phỏng, 2-3 tiếng nữa để copy dữ liệu về một kho chứa.

## Hai mũi tên trúng ba đích

Thời gian trôi qua, kỳ đầu tiên của năm thứ tư sắp kết thúc. Dù trầy trật nhưng đợt thí nghiệm ở kỳ đầu hoá ra lại thành công. Cô Z dự định cho X trình bày bài kết quả ở một hội thảo. Ban đầu X khá lưỡng lự vì còn phải lo đồ án tốt nghiệp. Nhưng sau đó, cô Z gọi diện và offer một công việc liên quan tại một dự án nghiên cứu cho X và Y. Big brain time, X nghĩ rằng mình có thể dùng project sẽ thực hiện ở công việc ở dự án trên để làm luôn đồ án tốt nghiệp, nhận luôn cả hai kèo. Nghe đâu, báo cáo ở hội thảo còn được cộng điểm vào đồ án.

Có một điều X không lường trước, đó là Covid, dịch khiến cho mọi công việc delay. X không thực sự làm việc cho dự án nghiên cứu kia cho tới một nửa kỳ hai năm bốn. X không dành đủ thời gian cho đồ án. Tua nhanh tới 2 tháng trước khi hết học kỳ. X không có chút tiến độ nào đồ án tốt nghiệp.
Cô Z offer rằng X có thể dùng bài rầy nâu này làm đồ án tốt nghiệp, thế là X lại làm việc nhởn nhơ trong vòng một tháng. Nhưng tới khi bắt đầu bắt tay vào viết báo cáo, X lại phát hiện ra một sai lầm chết người: mô hình này anh T (anh xây dựng mô hình ban đầu) đã dùng trong đồ án tốt nghiệp của mình, và X không thể dùng trong đồ án của mình được.

> Panik time <!-- TODO: ảnh -->

Trong cơn hoảng loạn, cô Z bảo X có thể thực hiện lại bài toán này với một mô hình mới, thậm chí cài đặt lại mô hình cũ bằng công cụ khác cũng được. Trong cái rủi lại có cái may, khi cài đặt lại mô hình bằng [Agents.jl](https://juliadynamics.github.io/Agents.jl/stable/), X phát hiện ra mô hình viết trên Agents chạy nhanh hơn khoảng... 1000 lần so với Gama, tức thời gian chạy được rút từ 10 phút xuống còn khoảng 0.3 giây. Hơn nữa, bằng cách sử dụng các tool lập trình song song của Julia, X có thể thử nghiệm toàn bộ 64000 mô phỏng như trước trong một đêm, trên máy tính cá nhân.

## Phức tạp hoá và tối ưu

Tưởng như mọi việc đã thành công tốt đẹp, khi viết báo cáo, X lại bới ra sạn trong mô hình. Khi ngẫm lại về một số lựa chọn khi thiết kế trong mô hình, nhiều chi tiết có vẻ vô lý:
- Tại sao con rầy nào cũng có thể đẻ, chỉ có con cái mới có thể đẻ chứ?
- Tại sao con rầy nào cũng di chuyển ngẫu nhiên sang một ô bên cạnh, ô đó không có lúa thì nó nhảy sang làm gì?
- Tại sao rầy đi qua hoa lại mất HP? (thực chất hoa chỉ thu hút ong, nhện... để tiêu diệt rầy, đi qua đây dính DOT là không chuẩn)

Đồng thời, nếu để mô hình của mình giống với mô hình của một người đã làm trước đó cũng không hay lắm. Thế là X cậy mình có tool ngon, ngồi cài thêm một đống thứ vào trong model. 

### Di chuyển nâng cao

Thay đổi đầu tiên là sự di chuyển của mấy con rầy. Giờ chúng không di chuyển ngẫu nhiên nữa. X nghĩ sự di chuyển phải theo xác suất, được phải được tính bởi yếu tố môi trường xung quanh và có lợi cho rầy nâu. Cách đơn giản nhất là sử dụng chính HP của lúa để tính xác suất. Phiên bản chọn đường đi đầu tiên:
```julia
# model là trạng thái của mô hình
# x, y là vị trí con rầy
# directions là tập các hướng di chuyển có thể
# đầu ra là một cặp hướng (x, y)
function select_direction(model, x, y, directions)::Tuple{<:Integer,<:Integer}
    for (dx, dy) in directions
        foodlim = get(model.food, (x + dx, y + dy), 0)
        should_select = if isnan(foodlim)
            rand(model.rng) ≤ 0.5
        else
            rand(model.rng) ≤ foodlim
        end
        if should_select
            return (dx, dy)
        end
    end
    return rand(model.rng, directions)
end
```

Thuật toán lựa chọn có thể hiểu như sau:
1. Lặp qua các ô có thể di chuyển tới.
2. Nếu ô đó là hoa, chọn ô đó với xác suất $0.5$.
3. Nếu ô đó là lúa, chọn ô đó với xác suất là HP của nó.
4. Nếu không có ô nào được chọn, chọn ngẫu nhiên một ô trong số các ô.

Dù nghe rất hợp lý nhưng thuật toán trên thất bại thảm hại, lý do là đám rầy sẽ di chuyển theo cùng một phía sang ô lúa có HP cao nhất, tạo ra một mẫu hình di chuyển kì dị. X phải revert lại commit vừa rồi để thay bằng một thuật toán khác.


