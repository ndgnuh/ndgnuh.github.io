---
title: "Links: thuật toán clustering online cho dữ liệu đa chiều"
date: 2020-08-14T21:23:17+07:00
draft: true
summary: "Thuật toán phân cụm Links cho dữ liệu nhiều chiều"
description: "Thuật toán phân cụm Links cho dữ liệu nhiều chiều"
categories:
tags:
- Thuật toán
keywords:
- Thuật toán
- Phân cụm
- Clustering
- Links
---

Bài viết tham khảo [arXiv:1801.10123](https://arxiv.org/abs/1801.10123), mọi credit cho tác giả.

Dù có nhiều thuật toán phân cụm đã được đưa ra, chúng đều giả sử rằng chúng ta có thể truy cập mọi điểm dữ liệu một cách đồng thời. Trái với những thuật toán như trên Links là thuật toán phù hợp cho loại dữ liệu mà được stream từ từ và liên tục vào trong một hệ thống.

Mục đích của Links là phân cụm một cách hiệu quả mỗi điểm dữ liệu khi nó xuất hiện. Cách tiếp cận là đánh giá phân phối xác suất của mỗi cụm dựa trên các vector thành phần.

