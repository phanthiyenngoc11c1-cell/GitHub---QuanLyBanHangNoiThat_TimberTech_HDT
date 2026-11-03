
IF DB_ID('TimberTech_QLNoiThat') IS NULL
    CREATE DATABASE TimberTech_QLNoiThat;
GO
USE TimberTech_QLNoiThat;
GO

IF OBJECT_ID('dbo.SANPHAM_KHUYENMAI', 'U') IS NOT NULL DROP TABLE dbo.SANPHAM_KHUYENMAI;
IF OBJECT_ID('dbo.CHITIETPHIEUXUAT', 'U') IS NOT NULL DROP TABLE dbo.CHITIETPHIEUXUAT;
IF OBJECT_ID('dbo.PHIEUXUATKHO', 'U') IS NOT NULL DROP TABLE dbo.PHIEUXUATKHO;
IF OBJECT_ID('dbo.CHITIETPHIEUNHAP', 'U') IS NOT NULL DROP TABLE dbo.CHITIETPHIEUNHAP;
IF OBJECT_ID('dbo.PHIEUNHAPKHO', 'U') IS NOT NULL DROP TABLE dbo.PHIEUNHAPKHO;
IF OBJECT_ID('dbo.HOADON', 'U') IS NOT NULL DROP TABLE dbo.HOADON;
IF OBJECT_ID('dbo.THANHTOAN', 'U') IS NOT NULL DROP TABLE dbo.THANHTOAN;
IF OBJECT_ID('dbo.CHITIETDONHANG', 'U') IS NOT NULL DROP TABLE dbo.CHITIETDONHANG;
IF OBJECT_ID('dbo.DONHANG', 'U') IS NOT NULL DROP TABLE dbo.DONHANG;
IF OBJECT_ID('dbo.CHITIETGIOHANG', 'U') IS NOT NULL DROP TABLE dbo.CHITIETGIOHANG;
IF OBJECT_ID('dbo.GIOHANG', 'U') IS NOT NULL DROP TABLE dbo.GIOHANG;
IF OBJECT_ID('dbo.BAOCAO', 'U') IS NOT NULL DROP TABLE dbo.BAOCAO;
IF OBJECT_ID('dbo.KHUYENMAI', 'U') IS NOT NULL DROP TABLE dbo.KHUYENMAI;
IF OBJECT_ID('dbo.SANPHAM', 'U') IS NOT NULL DROP TABLE dbo.SANPHAM;
IF OBJECT_ID('dbo.DANHMUCSANPHAM', 'U') IS NOT NULL DROP TABLE dbo.DANHMUCSANPHAM;
IF OBJECT_ID('dbo.NHANVIEN', 'U') IS NOT NULL DROP TABLE dbo.NHANVIEN;
IF OBJECT_ID('dbo.KHACHHANG', 'U') IS NOT NULL DROP TABLE dbo.KHACHHANG;
IF OBJECT_ID('dbo.TAIKHOAN', 'U') IS NOT NULL DROP TABLE dbo.TAIKHOAN;
GO

CREATE TABLE TAIKHOAN (
    MaTaiKhoan CHAR(10) PRIMARY KEY,
    TenDangNhap VARCHAR(50) NOT NULL UNIQUE,
    MatKhau VARCHAR(255) NOT NULL,
    VaiTro NVARCHAR(50) NOT NULL,
    TrangThai NVARCHAR(30) NOT NULL,
    NgayTao DATETIME NOT NULL,
    LanDangNhapCuoi DATETIME NULL,
    CONSTRAINT CK_TAIKHOAN_VaiTro CHECK (VaiTro IN (N'Khách hàng', N'Nhân viên bán hàng', N'Thủ kho', N'Nhân viên kế toán', N'Ban quản lý', N'Quản trị viên')),
    CONSTRAINT CK_TAIKHOAN_TrangThai CHECK (TrangThai IN (N'Hoạt động', N'Khóa', N'Tạm khóa'))
);

CREATE TABLE KHACHHANG (
    MaKhachHang CHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    SoDienThoai VARCHAR(10) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    GioiTinh NVARCHAR(10) NULL,
    NgaySinh DATE NULL,
    NgayDangKy DATETIME NOT NULL,
    TrangThai NVARCHAR(30) NOT NULL,
    MaTaiKhoan CHAR(10) NOT NULL UNIQUE,
    CONSTRAINT FK_KHACHHANG_TAIKHOAN FOREIGN KEY (MaTaiKhoan) REFERENCES TAIKHOAN(MaTaiKhoan),
    CONSTRAINT CK_KHACHHANG_TrangThai CHECK (TrangThai IN (N'Hoạt động', N'Ngưng hoạt động')),
    CONSTRAINT CK_KHACHHANG_GioiTinh CHECK (GioiTinh IN (N'Nam', N'Nữ'))
);

CREATE TABLE NHANVIEN (
    MaNhanVien CHAR(10) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    SoDienThoai VARCHAR(10) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    GioiTinh NVARCHAR(10) NULL,
    NgaySinh DATE NULL,
    ChucDanh NVARCHAR(50) NOT NULL,
    NgayVaoLam DATE NOT NULL,
    TrangThai NVARCHAR(30) NOT NULL,
    MaTaiKhoan CHAR(10) NOT NULL UNIQUE,
    CONSTRAINT FK_NHANVIEN_TAIKHOAN FOREIGN KEY (MaTaiKhoan) REFERENCES TAIKHOAN(MaTaiKhoan),
    CONSTRAINT CK_NHANVIEN_TrangThai CHECK (TrangThai IN (N'Đang làm việc', N'Nghỉ việc', N'Tạm nghỉ')),
    CONSTRAINT CK_NHANVIEN_GioiTinh CHECK (GioiTinh IN (N'Nam', N'Nữ'))
);

CREATE TABLE DANHMUCSANPHAM (
    MaDanhMuc CHAR(10) PRIMARY KEY,
    TenDanhMuc NVARCHAR(150) NOT NULL,
    MoTa NVARCHAR(255) NULL,
    TrangThai NVARCHAR(30) NOT NULL,
    CONSTRAINT CK_DANHMUC_TrangThai CHECK (TrangThai IN (N'Hoạt động', N'Ngưng áp dụng'))
);

CREATE TABLE SANPHAM (
    MaSanPham CHAR(10) PRIMARY KEY,
    TenSanPham NVARCHAR(150) NOT NULL,
    MoTa NVARCHAR(500) NULL,
    DonViTinh NVARCHAR(30) NOT NULL,
    DonGia DECIMAL(18,2) NOT NULL,
    SoLuongTon INT NOT NULL DEFAULT 0,
    HinhAnh VARCHAR(255) NULL,
    TrangThaiKinhDoanh NVARCHAR(30) NOT NULL,
    MaDanhMuc CHAR(10) NOT NULL,
    CONSTRAINT FK_SANPHAM_DANHMUC FOREIGN KEY (MaDanhMuc) REFERENCES DANHMUCSANPHAM(MaDanhMuc),
    CONSTRAINT CK_SANPHAM_DonGia CHECK (DonGia > 0),
    CONSTRAINT CK_SANPHAM_SoLuongTon CHECK (SoLuongTon >= 0),
    CONSTRAINT CK_SANPHAM_TrangThai CHECK (TrangThaiKinhDoanh IN (N'Đang kinh doanh', N'Ngừng kinh doanh'))
);

CREATE TABLE GIOHANG (
    MaGioHang CHAR(10) PRIMARY KEY,
    NgayTao DATETIME NOT NULL,
    TrangThai NVARCHAR(30) NOT NULL,
    MaKhachHang CHAR(10) NOT NULL UNIQUE,
    CONSTRAINT FK_GIOHANG_KHACHHANG FOREIGN KEY (MaKhachHang) REFERENCES KHACHHANG(MaKhachHang),
    CONSTRAINT CK_GIOHANG_TrangThai CHECK (TrangThai IN (N'Đang hoạt động', N'Đã chuyển đơn', N'Đã hủy'))
);

CREATE TABLE CHITIETGIOHANG (
    MaGioHang CHAR(10) NOT NULL,
    MaSanPham CHAR(10) NOT NULL,
    SoLuong INT NOT NULL,
    DonGiaTaiThoiDiemThem DECIMAL(18,2) NOT NULL,
    ThanhTienTamTinh DECIMAL(18,2) NOT NULL,
    PRIMARY KEY (MaGioHang, MaSanPham),
    CONSTRAINT FK_CTGH_GIOHANG FOREIGN KEY (MaGioHang) REFERENCES GIOHANG(MaGioHang),
    CONSTRAINT FK_CTGH_SANPHAM FOREIGN KEY (MaSanPham) REFERENCES SANPHAM(MaSanPham),
    CONSTRAINT CK_CTGH_SoLuong CHECK (SoLuong > 0),
    CONSTRAINT CK_CTGH_DonGia CHECK (DonGiaTaiThoiDiemThem > 0),
    CONSTRAINT CK_CTGH_ThanhTien CHECK (ThanhTienTamTinh >= 0)
);

CREATE TABLE DONHANG (
    MaDonHang CHAR(10) PRIMARY KEY,
    NgayDat DATETIME NOT NULL,
    TongTien DECIMAL(18,2) NOT NULL,
    TrangThai NVARCHAR(30) NOT NULL,
    DiaChiGiaoHang NVARCHAR(255) NOT NULL,
    SoDienThoaiNhanHang VARCHAR(15) NOT NULL,
    GhiChu NVARCHAR(255) NULL,
    MaKhachHang CHAR(10) NOT NULL,
    CONSTRAINT FK_DONHANG_KHACHHANG FOREIGN KEY (MaKhachHang) REFERENCES KHACHHANG(MaKhachHang),
    CONSTRAINT CK_DONHANG_TongTien CHECK (TongTien >= 0),
    CONSTRAINT CK_DONHANG_TrangThai CHECK (TrangThai IN (N'Chờ xác nhận', N'Đã xác nhận', N'Đang xử lý', N'Đang giao', N'Hoàn tất', N'Đã hủy'))
);

CREATE TABLE CHITIETDONHANG (
    MaDonHang CHAR(10) NOT NULL,
    MaSanPham CHAR(10) NOT NULL,
    SoLuong INT NOT NULL,
    DonGia DECIMAL(18,2) NOT NULL,
    ThanhTien DECIMAL(18,2) NOT NULL,
    GhiChu NVARCHAR(255) NULL,
    PRIMARY KEY (MaDonHang, MaSanPham),
    CONSTRAINT FK_CTDH_DONHANG FOREIGN KEY (MaDonHang) REFERENCES DONHANG(MaDonHang),
    CONSTRAINT FK_CTDH_SANPHAM FOREIGN KEY (MaSanPham) REFERENCES SANPHAM(MaSanPham),
    CONSTRAINT CK_CTDH_SoLuong CHECK (SoLuong > 0),
    CONSTRAINT CK_CTDH_DonGia CHECK (DonGia > 0),
    CONSTRAINT CK_CTDH_ThanhTien CHECK (ThanhTien >= 0)
);

CREATE TABLE THANHTOAN (
    MaThanhToan CHAR(10) PRIMARY KEY,
    PhuongThucThanhToan NVARCHAR(50) NOT NULL,
    SoTien DECIMAL(18,2) NOT NULL,
    TrangThai NVARCHAR(30) NOT NULL,
    NgayThanhToan DATETIME NULL,
    GhiChu NVARCHAR(255) NULL,
    MaDonHang CHAR(10) NOT NULL UNIQUE,
    MaNhanVien CHAR(10) NULL,
    CONSTRAINT FK_THANHTOAN_DONHANG FOREIGN KEY (MaDonHang) REFERENCES DONHANG(MaDonHang),
    CONSTRAINT FK_THANHTOAN_NHANVIEN FOREIGN KEY (MaNhanVien) REFERENCES NHANVIEN(MaNhanVien),
    CONSTRAINT CK_THANHTOAN_SoTien CHECK (SoTien >= 0),
    CONSTRAINT CK_THANHTOAN_PhuongThuc CHECK (PhuongThucThanhToan IN (N'Chưa chọn', N'Thanh toán khi nhận hàng', N'Chuyển khoản')),
    CONSTRAINT CK_THANHTOAN_TrangThai CHECK (TrangThai IN (N'Chưa thanh toán', N'Chờ xác nhận thanh toán', N'Đã thanh toán', N'Thanh toán thất bại', N'Đã hủy'))
);

CREATE TABLE HOADON (
    MaHoaDon CHAR(10) PRIMARY KEY,
    NgayLap DATETIME NOT NULL,
    TongTien DECIMAL(18,2) NOT NULL,
    TrangThaiThanhToan NVARCHAR(30) NOT NULL,
    ThueVAT DECIMAL(5,2) NOT NULL,
    MaSoThue VARCHAR(20) NULL,
    DiaChiXuatHoaDon NVARCHAR(255) NOT NULL,
    MaDonHang CHAR(10) NOT NULL UNIQUE,
    MaNhanVien CHAR(10) NOT NULL,
    CONSTRAINT FK_HOADON_DONHANG FOREIGN KEY (MaDonHang) REFERENCES DONHANG(MaDonHang),
    CONSTRAINT FK_HOADON_NHANVIEN FOREIGN KEY (MaNhanVien) REFERENCES NHANVIEN(MaNhanVien),
    CONSTRAINT CK_HOADON_TongTien CHECK (TongTien >= 0),
    CONSTRAINT CK_HOADON_ThueVAT CHECK (ThueVAT >= 0 AND ThueVAT <= 100),
    CONSTRAINT CK_HOADON_TrangThai CHECK (TrangThaiThanhToan IN (N'Chưa thanh toán', N'Đã thanh toán'))
);

CREATE TABLE PHIEUNHAPKHO (
    MaPhieuNhap CHAR(10) PRIMARY KEY,
    NgayNhap DATETIME NOT NULL,
    TongSoLuong INT NOT NULL,
    TongTienNhap DECIMAL(18,2) NOT NULL,
    NhaCungCap NVARCHAR(150) NOT NULL,
    GhiChu NVARCHAR(255) NULL,
    TrangThai NVARCHAR(30) NOT NULL,
    MaNhanVien CHAR(10) NOT NULL,
    CONSTRAINT FK_PNK_NHANVIEN FOREIGN KEY (MaNhanVien) REFERENCES NHANVIEN(MaNhanVien),
    CONSTRAINT CK_PNK_TongSoLuong CHECK (TongSoLuong > 0),
    CONSTRAINT CK_PNK_TongTien CHECK (TongTienNhap > 0),
    CONSTRAINT CK_PNK_TrangThai CHECK (TrangThai IN (N'Đã nhập', N'Nháp', N'Đã hủy'))
);

CREATE TABLE CHITIETPHIEUNHAP (
    MaPhieuNhap CHAR(10) NOT NULL,
    MaSanPham CHAR(10) NOT NULL,
    SoLuongNhap INT NOT NULL,
    DonGiaNhap DECIMAL(18,2) NOT NULL,
    ThanhTienNhap DECIMAL(18,2) NOT NULL,
    PRIMARY KEY (MaPhieuNhap, MaSanPham),
    CONSTRAINT FK_CTPN_PNK FOREIGN KEY (MaPhieuNhap) REFERENCES PHIEUNHAPKHO(MaPhieuNhap),
    CONSTRAINT FK_CTPN_SANPHAM FOREIGN KEY (MaSanPham) REFERENCES SANPHAM(MaSanPham),
    CONSTRAINT CK_CTPN_SoLuong CHECK (SoLuongNhap > 0),
    CONSTRAINT CK_CTPN_DonGia CHECK (DonGiaNhap > 0),
    CONSTRAINT CK_CTPN_ThanhTien CHECK (ThanhTienNhap > 0)
);

CREATE TABLE PHIEUXUATKHO (
    MaPhieuXuat CHAR(10) PRIMARY KEY,
    NgayXuat DATETIME NOT NULL,
    TongSoLuong INT NOT NULL,
    GhiChu NVARCHAR(255) NULL,
    TrangThai NVARCHAR(30) NOT NULL,
    MaDonHang CHAR(10) NOT NULL UNIQUE,
    MaNhanVien CHAR(10) NOT NULL,
    CONSTRAINT FK_PXK_DONHANG FOREIGN KEY (MaDonHang) REFERENCES DONHANG(MaDonHang),
    CONSTRAINT FK_PXK_NHANVIEN FOREIGN KEY (MaNhanVien) REFERENCES NHANVIEN(MaNhanVien),
    CONSTRAINT CK_PXK_TongSoLuong CHECK (TongSoLuong > 0),
    CONSTRAINT CK_PXK_TrangThai CHECK (TrangThai IN (N'Đã lập phiếu', N'Đã xuất kho', N'Đã hủy'))
);

CREATE TABLE CHITIETPHIEUXUAT (
    MaPhieuXuat CHAR(10) NOT NULL,
    MaSanPham CHAR(10) NOT NULL,
    SoLuongXuat INT NOT NULL,
    GhiChu NVARCHAR(255) NULL,
    PRIMARY KEY (MaPhieuXuat, MaSanPham),
    CONSTRAINT FK_CTPX_PXK FOREIGN KEY (MaPhieuXuat) REFERENCES PHIEUXUATKHO(MaPhieuXuat),
    CONSTRAINT FK_CTPX_SANPHAM FOREIGN KEY (MaSanPham) REFERENCES SANPHAM(MaSanPham),
    CONSTRAINT CK_CTPX_SoLuong CHECK (SoLuongXuat > 0)
);

CREATE TABLE KHUYENMAI (
    MaKhuyenMai CHAR(10) PRIMARY KEY,
    TenKhuyenMai NVARCHAR(150) NOT NULL,
    GiaTri DECIMAL(18,2) NOT NULL,
    NgayBatDau DATE NOT NULL,
    NgayKetThuc DATE NOT NULL,
    DieuKienApDung NVARCHAR(255) NULL,
    MoTa NVARCHAR(500) NULL,
    TrangThai NVARCHAR(30) NOT NULL,
    CONSTRAINT CK_KM_GiaTri CHECK (GiaTri > 0),
    CONSTRAINT CK_KM_Ngay CHECK (NgayBatDau <= NgayKetThuc),
    CONSTRAINT CK_KM_TrangThai CHECK (TrangThai IN (N'Đang áp dụng', N'Hết hiệu lực', N'Tạm ngưng'))
);

CREATE TABLE SANPHAM_KHUYENMAI (
    MaSanPham CHAR(10) NOT NULL,
    MaKhuyenMai CHAR(10) NOT NULL,
    PRIMARY KEY (MaSanPham, MaKhuyenMai),
    CONSTRAINT FK_SPKM_SANPHAM FOREIGN KEY (MaSanPham) REFERENCES SANPHAM(MaSanPham),
    CONSTRAINT FK_SPKM_KHUYENMAI FOREIGN KEY (MaKhuyenMai) REFERENCES KHUYENMAI(MaKhuyenMai)
);

CREATE TABLE BAOCAO (
    MaBaoCao CHAR(10) PRIMARY KEY,
    TenBaoCao NVARCHAR(150) NOT NULL,
    NgayLap DATETIME NOT NULL,
    NoiDung NVARCHAR(500) NULL,
    LoaiBaoCao NVARCHAR(50) NOT NULL,
    TuNgay DATE NOT NULL,
    DenNgay DATE NOT NULL,
    MaNhanVien CHAR(10) NOT NULL,
    CONSTRAINT FK_BAOCAO_NHANVIEN FOREIGN KEY (MaNhanVien) REFERENCES NHANVIEN(MaNhanVien),
    CONSTRAINT CK_BAOCAO_Ngay CHECK (TuNgay <= DenNgay)
);
GO
INSERT INTO TAIKHOAN (MaTaiKhoan, TenDangNhap, MatKhau, VaiTro, TrangThai, NgayTao, LanDangNhapCuoi) VALUES
('TK00000001', 'khach01', '123456@Abc', N'Khách hàng', N'Hoạt động', '2025-03-02 09:00:00', '2026-04-02 20:15:00'),
('TK00000002', 'khach02', '123456@Abc', N'Khách hàng', N'Hoạt động', '2025-04-03 09:00:00', '2026-01-03 20:15:00'),
('TK00000003', 'khach03', '123456@Abc', N'Khách hàng', N'Hoạt động', '2025-05-04 09:00:00', '2026-02-04 20:15:00'),
('TK00000004', 'khach04', '123456@Abc', N'Khách hàng', N'Hoạt động', '2025-06-05 09:00:00', '2026-03-05 20:15:00'),
('TK00000005', 'khach05', '123456@Abc', N'Khách hàng', N'Hoạt động', '2025-07-06 09:00:00', '2026-04-06 20:15:00'),
('TK00000006', 'khach06', '123456@Abc', N'Khách hàng', N'Hoạt động', '2025-08-07 09:00:00', '2026-01-07 20:15:00'),
('TK00000007', 'khach07', '123456@Abc', N'Khách hàng', N'Hoạt động', '2025-09-08 09:00:00', '2026-02-08 20:15:00'),
('TK00000008', 'khach08', '123456@Abc', N'Khách hàng', N'Hoạt động', '2025-10-09 09:00:00', '2026-03-09 20:15:00'),
('TK00000009', 'khach09', '123456@Abc', N'Khách hàng', N'Hoạt động', '2025-11-10 09:00:00', '2026-04-10 20:15:00'),
('TK00000010', 'khach10', '123456@Abc', N'Khách hàng', N'Hoạt động', '2025-12-11 09:00:00', '2026-01-11 20:15:00'),
('TK00000011', 'khach11', '123456@Abc', N'Khách hàng', N'Hoạt động', '2025-01-12 09:00:00', '2026-02-12 20:15:00'),
('TK00000012', 'khach12', '123456@Abc', N'Khách hàng', N'Hoạt động', '2025-02-13 09:00:00', '2026-03-13 20:15:00'),
('TK00000013', 'khach13', '123456@Abc', N'Khách hàng', N'Hoạt động', '2025-03-14 09:00:00', '2026-04-14 20:15:00'),
('TK00000014', 'khach14', '123456@Abc', N'Khách hàng', N'Hoạt động', '2025-04-15 09:00:00', '2026-01-15 20:15:00'),
('TK00000015', 'khach15', '123456@Abc', N'Khách hàng', N'Hoạt động', '2025-05-16 09:00:00', '2026-02-16 20:15:00'),
('TK00000016', 'khach16', '123456@Abc', N'Khách hàng', N'Hoạt động', '2025-06-17 09:00:00', '2026-03-17 20:15:00'),
('TK00000017', 'khach17', '123456@Abc', N'Khách hàng', N'Hoạt động', '2025-07-18 09:00:00', '2026-04-18 20:15:00'),
('TK00000018', 'khach18', '123456@Abc', N'Khách hàng', N'Hoạt động', '2025-08-19 09:00:00', '2026-01-19 20:15:00'),
('TK00000019', 'khach19', '123456@Abc', N'Khách hàng', N'Hoạt động', '2025-09-20 09:00:00', '2026-02-20 20:15:00'),
('TK00000020', 'khach20', '123456@Abc', N'Khách hàng', N'Hoạt động', '2025-10-21 09:00:00', '2026-03-21 20:15:00'),
('TK00000021', 'nhanvien01', '123456@Abc', N'Nhân viên bán hàng', N'Hoạt động', '2024-05-02 08:00:00', '2026-04-02 08:30:00'),
('TK00000022', 'nhanvien02', '123456@Abc', N'Thủ kho', N'Hoạt động', '2024-06-03 08:00:00', '2026-04-03 08:30:00'),
('TK00000023', 'nhanvien03', '123456@Abc', N'Nhân viên kế toán', N'Hoạt động', '2024-07-04 08:00:00', '2026-04-04 08:30:00'),
('TK00000024', 'nhanvien04', '123456@Abc', N'Ban quản lý', N'Hoạt động', '2024-08-05 08:00:00', '2026-04-05 08:30:00'),
('TK00000025', 'nhanvien05', '123456@Abc', N'Quản trị viên', N'Hoạt động', '2024-09-06 08:00:00', '2026-04-06 08:30:00'),
('TK00000026', 'nhanvien06', '123456@Abc', N'Nhân viên bán hàng', N'Hoạt động', '2024-10-07 08:00:00', '2026-04-07 08:30:00'),
('TK00000027', 'nhanvien07', '123456@Abc', N'Thủ kho', N'Hoạt động', '2024-11-08 08:00:00', '2026-04-08 08:30:00'),
('TK00000028', 'nhanvien08', '123456@Abc', N'Nhân viên kế toán', N'Hoạt động', '2024-12-09 08:00:00', '2026-04-09 08:30:00'),
('TK00000029', 'nhanvien09', '123456@Abc', N'Ban quản lý', N'Hoạt động', '2024-01-10 08:00:00', '2026-04-10 08:30:00'),
('TK00000030', 'nhanvien10', '123456@Abc', N'Quản trị viên', N'Hoạt động', '2024-02-11 08:00:00', '2026-04-11 08:30:00'),
('TK00000031', 'nhanvien11', '123456@Abc', N'Nhân viên bán hàng', N'Hoạt động', '2024-03-12 08:00:00', '2026-04-12 08:30:00'),
('TK00000032', 'nhanvien12', '123456@Abc', N'Thủ kho', N'Hoạt động', '2024-04-13 08:00:00', '2026-04-13 08:30:00'),
('TK00000033', 'nhanvien13', '123456@Abc', N'Nhân viên kế toán', N'Hoạt động', '2024-05-14 08:00:00', '2026-04-14 08:30:00'),
('TK00000034', 'nhanvien14', '123456@Abc', N'Ban quản lý', N'Hoạt động', '2024-06-15 08:00:00', '2026-04-01 08:30:00'),
('TK00000035', 'nhanvien15', '123456@Abc', N'Quản trị viên', N'Hoạt động', '2024-07-16 08:00:00', '2026-04-02 08:30:00'),
('TK00000036', 'nhanvien16', '123456@Abc', N'Nhân viên bán hàng', N'Hoạt động', '2024-08-17 08:00:00', '2026-04-03 08:30:00'),
('TK00000037', 'nhanvien17', '123456@Abc', N'Thủ kho', N'Hoạt động', '2024-09-18 08:00:00', '2026-04-04 08:30:00'),
('TK00000038', 'nhanvien18', '123456@Abc', N'Nhân viên kế toán', N'Hoạt động', '2024-10-19 08:00:00', '2026-04-05 08:30:00'),
('TK00000039', 'nhanvien19', '123456@Abc', N'Ban quản lý', N'Hoạt động', '2024-11-20 08:00:00', '2026-04-06 08:30:00'),
('TK00000040', 'nhanvien20', '123456@Abc', N'Quản trị viên', N'Hoạt động', '2024-12-21 08:00:00', '2026-04-07 08:30:00');

INSERT INTO KHACHHANG (MaKhachHang, HoTen, SoDienThoai, Email, GioiTinh, NgaySinh, NgayDangKy, TrangThai, MaTaiKhoan) VALUES
('KH00000001', N'Nguyễn Minh Anh', '0910000001', 'kh01@gmail.com', N'Nữ', '1997-03-14', '2025-03-02 09:00:00', N'Hoạt động', 'TK00000001'),
('KH00000002', N'Trần Quốc Bảo', '0910000002', 'kh02@gmail.com', N'Nam', '1991-07-21', '2025-04-03 09:00:00', N'Hoạt động', 'TK00000002'),
('KH00000003', N'Lê Thu Hà', '0910000003', 'kh03@gmail.com', N'Nữ', '1995-11-06', '2025-05-04 09:00:00', N'Hoạt động', 'TK00000003'),
('KH00000004', N'Phạm Gia Huy', '0910000004', 'kh04@gmail.com', N'Nam', '1989-01-18', '2025-06-05 09:00:00', N'Hoạt động', 'TK00000004'),
('KH00000005', N'Võ Ngọc Lan', '0910000005', 'kh05@gmail.com', N'Nữ', '1996-09-27', '2025-07-06 09:00:00', N'Hoạt động', 'TK00000005'),
('KH00000006', N'Đặng Hoàng Nam', '0910000006', 'kh06@gmail.com', N'Nam', '1992-12-12', '2025-08-07 09:00:00', N'Hoạt động', 'TK00000006'),
('KH00000007', N'Bùi Khánh Linh', '0910000007', 'kh07@gmail.com', N'Nữ', '1998-04-05', '2025-09-08 09:00:00', N'Hoạt động', 'TK00000007'),
('KH00000008', N'Ngô Đức Long', '0910000008', 'kh08@gmail.com', N'Nam', '1990-08-30', '2025-10-09 09:00:00', N'Hoạt động', 'TK00000008'),
('KH00000009', N'Phan Thị Mai', '0910000009', 'kh09@gmail.com', N'Nữ', '1994-06-11', '2025-11-10 09:00:00', N'Hoạt động', 'TK00000009'),
('KH00000010', N'Đỗ Thành Đạt', '0910000010', 'kh10@gmail.com', N'Nam', '1988-02-25', '2025-12-11 09:00:00', N'Hoạt động', 'TK00000010'),
('KH00000011', N'Huỳnh Bảo Trâm', '0910000011', 'kh11@gmail.com', N'Nữ', '1993-05-16', '2025-01-12 09:00:00', N'Hoạt động', 'TK00000011'),
('KH00000012', N'Trương Nhật Quang', '0910000012', 'kh12@gmail.com', N'Nam', '1987-10-02', '2025-02-13 09:00:00', N'Hoạt động', 'TK00000012'),
('KH00000013', N'Nguyễn Thảo My', '0910000013', 'kh13@gmail.com', N'Nữ', '1999-01-09', '2025-03-14 09:00:00', N'Hoạt động', 'TK00000013'),
('KH00000014', N'Lý Hoàng Phúc', '0910000014', 'kh14@gmail.com', N'Nam', '1991-03-28', '2025-04-15 09:00:00', N'Hoạt động', 'TK00000014'),
('KH00000015', N'Tạ Kim Ngân', '0910000015', 'kh15@gmail.com', N'Nữ', '1995-12-20', '2025-05-16 09:00:00', N'Hoạt động', 'TK00000015'),
('KH00000016', N'Mai Anh Khoa', '0910000016', 'kh16@gmail.com', N'Nam', '1990-07-15', '2025-06-17 09:00:00', N'Hoạt động', 'TK00000016'),
('KH00000017', N'Phạm Thanh Tùng', '0910000017', 'kh17@gmail.com', N'Nam', '1986-04-18', '2025-07-18 09:00:00', N'Hoạt động', 'TK00000017'),
('KH00000018', N'Dương Gia Hân', '0910000018', 'kh18@gmail.com', N'Nữ', '1997-08-22', '2025-08-19 09:00:00', N'Hoạt động', 'TK00000018'),
('KH00000019', N'Lê Quốc Khải', '0910000019', 'kh19@gmail.com', N'Nam', '1992-06-01', '2025-09-20 09:00:00', N'Hoạt động', 'TK00000019'),
('KH00000020', N'Trần Mỹ Duyên', '0910000020', 'kh20@gmail.com', N'Nữ', '1996-10-13', '2025-10-21 09:00:00', N'Hoạt động', 'TK00000020');

INSERT INTO NHANVIEN (MaNhanVien, HoTen, SoDienThoai, Email, GioiTinh, NgaySinh, ChucDanh, NgayVaoLam, TrangThai, MaTaiKhoan) VALUES
('NV00000001', N'Nguyễn Đức Huy', '0909000001', 'nv01@timbertech.vn', N'Nam', '1990-05-11', N'Nhân viên bán hàng', '2023-02-01', N'Đang làm việc', 'TK00000021'),
('NV00000002', N'Trần Thị Phương', '0909000002', 'nv02@timbertech.vn', N'Nữ', '1992-07-19', N'Thủ kho', '2023-03-15', N'Đang làm việc', 'TK00000022'),
('NV00000003', N'Lê Văn Thành', '0909000003', 'nv03@timbertech.vn', N'Nam', '1988-10-03', N'Nhân viên kế toán', '2022-11-20', N'Đang làm việc', 'TK00000023'),
('NV00000004', N'Phạm Thu Trang', '0909000004', 'nv04@timbertech.vn', N'Nữ', '1987-12-14', N'Ban quản lý', '2021-09-10', N'Đang làm việc', 'TK00000024'),
('NV00000005', N'Bùi Quang Vinh', '0909000005', 'nv05@timbertech.vn', N'Nam', '1989-09-09', N'Quản trị viên', '2022-05-05', N'Đang làm việc', 'TK00000025'),
('NV00000006', N'Đỗ Ngọc Hà', '0909000006', 'nv06@timbertech.vn', N'Nữ', '1994-01-22', N'Nhân viên bán hàng', '2024-01-08', N'Đang làm việc', 'TK00000026'),
('NV00000007', N'Võ Minh Tâm', '0909000007', 'nv07@timbertech.vn', N'Nam', '1991-02-17', N'Thủ kho', '2024-02-18', N'Đang làm việc', 'TK00000027'),
('NV00000008', N'Nguyễn Hải Yến', '0909000008', 'nv08@timbertech.vn', N'Nữ', '1993-03-30', N'Nhân viên kế toán', '2023-07-12', N'Đang làm việc', 'TK00000028'),
('NV00000009', N'Trần Văn Phúc', '0909000009', 'nv09@timbertech.vn', N'Nam', '1988-08-08', N'Ban quản lý', '2022-06-01', N'Đang làm việc', 'TK00000029'),
('NV00000010', N'Lê Bảo Ngọc', '0909000010', 'nv10@timbertech.vn', N'Nữ', '1995-06-25', N'Quản trị viên', '2023-10-20', N'Đang làm việc', 'TK00000030'),
('NV00000011', N'Phan Hoàng Long', '0909000011', 'nv11@timbertech.vn', N'Nam', '1992-04-13', N'Nhân viên bán hàng', '2024-03-11', N'Đang làm việc', 'TK00000031'),
('NV00000012', N'Dương Thu Thảo', '0909000012', 'nv12@timbertech.vn', N'Nữ', '1990-11-21', N'Thủ kho', '2024-04-15', N'Đang làm việc', 'TK00000032'),
('NV00000013', N'Huỳnh Gia Bảo', '0909000013', 'nv13@timbertech.vn', N'Nam', '1989-01-29', N'Nhân viên kế toán', '2023-08-09', N'Đang làm việc', 'TK00000033'),
('NV00000014', N'Ngô Mỹ Linh', '0909000014', 'nv14@timbertech.vn', N'Nữ', '1994-09-16', N'Ban quản lý', '2022-12-01', N'Đang làm việc', 'TK00000034'),
('NV00000015', N'Tạ Quốc Cường', '0909000015', 'nv15@timbertech.vn', N'Nam', '1987-07-07', N'Quản trị viên', '2021-11-11', N'Đang làm việc', 'TK00000035'),
('NV00000016', N'Mai Thanh Vy', '0909000016', 'nv16@timbertech.vn', N'Nữ', '1996-05-19', N'Nhân viên bán hàng', '2024-05-06', N'Đang làm việc', 'TK00000036'),
('NV00000017', N'Lý Minh Khang', '0909000017', 'nv17@timbertech.vn', N'Nam', '1991-12-03', N'Thủ kho', '2024-06-10', N'Đang làm việc', 'TK00000037'),
('NV00000018', N'Đặng Yến Nhi', '0909000018', 'nv18@timbertech.vn', N'Nữ', '1993-10-27', N'Nhân viên kế toán', '2023-09-14', N'Đang làm việc', 'TK00000038'),
('NV00000019', N'Trương Quốc Anh', '0909000019', 'nv19@timbertech.vn', N'Nam', '1988-06-12', N'Ban quản lý', '2022-03-22', N'Đang làm việc', 'TK00000039'),
('NV00000020', N'Phạm Khánh Chi', '0909000020', 'nv20@timbertech.vn', N'Nữ', '1995-02-18', N'Quản trị viên', '2024-07-01', N'Đang làm việc', 'TK00000040');

INSERT INTO DANHMUCSANPHAM (MaDanhMuc, TenDanhMuc, MoTa, TrangThai) VALUES
('DM00000001', N'Sàn gỗ tự nhiên', N'Các dòng sàn gỗ tự nhiên cao cấp cho căn hộ, biệt thự.', N'Hoạt động'),
('DM00000002', N'Sàn gỗ công nghiệp', N'Các dòng sàn gỗ công nghiệp chống ẩm, chống trầy.', N'Hoạt động'),
('DM00000003', N'Sàn gỗ ngoài trời', N'Vật liệu ngoài trời cho ban công, sân vườn.', N'Hoạt động'),
('DM00000004', N'Phụ kiện lắp đặt', N'Len chân tường, nẹp nối, foam, keo và vật tư thi công.', N'Hoạt động'),
('DM00000005', N'Tấm ốp trang trí', N'Tấm ốp tường, lam sóng, vật liệu trang trí nội thất.', N'Hoạt động');

INSERT INTO SANPHAM (MaSanPham, TenSanPham, MoTa, DonViTinh, DonGia, SoLuongTon, HinhAnh, TrangThaiKinhDoanh, MaDanhMuc) VALUES
('SP00000001', N'Sàn gỗ Sồi 12mm', N'Bề mặt vân gỗ sồi, phù hợp phòng khách căn hộ.', N'm2', 285000, 95, 'sp_soi_12mm.jpg', N'Đang kinh doanh', 'DM00000001'),
('SP00000002', N'Sàn gỗ Óc chó 15mm', N'Tông màu nâu trầm, phù hợp biệt thự và showroom.', N'm2', 465000, 62, 'sp_occho_15mm.jpg', N'Đang kinh doanh', 'DM00000001'),
('SP00000003', N'Sàn gỗ Teak 15mm', N'Khả năng chịu ẩm tốt, màu sắc sang trọng.', N'm2', 520000, 55, 'sp_teak_15mm.jpg', N'Đang kinh doanh', 'DM00000001'),
('SP00000004', N'Sàn gỗ Chiu Liu 18mm', N'Dòng gỗ tự nhiên cao cấp cho không gian lớn.', N'm2', 680000, 48, 'sp_chiuliu_18mm.jpg', N'Đang kinh doanh', 'DM00000001'),
('SP00000005', N'Sàn gỗ Laminate Aqua 8mm', N'Dòng công nghiệp chống ẩm cơ bản cho chung cư.', N'm2', 225000, 174, 'sp_laminate_aqua_8mm.jpg', N'Đang kinh doanh', 'DM00000002'),
('SP00000006', N'Sàn gỗ Laminate Aqua 12mm', N'Bản dày 12mm, chịu lực tốt hơn bản 8mm.', N'm2', 295000, 158, 'sp_laminate_aqua_12mm.jpg', N'Đang kinh doanh', 'DM00000002'),
('SP00000007', N'Sàn gỗ HDF Premium 12mm', N'Lõi HDF mật độ cao, phù hợp phòng ngủ.', N'm2', 335000, 140, 'sp_hdf_premium_12mm.jpg', N'Đang kinh doanh', 'DM00000002'),
('SP00000008', N'Sàn gỗ Herringbone 12mm', N'Kiểu xương cá, phù hợp căn hộ phong cách hiện đại.', N'm2', 390000, 76, 'sp_herringbone_12mm.jpg', N'Đang kinh doanh', 'DM00000002'),
('SP00000009', N'Sàn ngoài trời WPC 1 lớp', N'Thanh WPC cơ bản cho ban công và lối đi.', N'm2', 645000, 57, 'sp_wpc_1lop.jpg', N'Đang kinh doanh', 'DM00000003'),
('SP00000010', N'Sàn ngoài trời WPC 2 lớp', N'Bề mặt phủ chống bạc màu, dùng cho sân vườn.', N'm2', 760000, 49, 'sp_wpc_2lop.jpg', N'Đang kinh doanh', 'DM00000003'),
('SP00000011', N'Vỉ gỗ ngoài trời 30x30', N'Vỉ lát ngoài trời lắp ghép nhanh.', N'hộp', 185000, 80, 'sp_vi_go_30x30.jpg', N'Đang kinh doanh', 'DM00000003'),
('SP00000012', N'Len chân tường 78mm', N'Len chân tường phủ film màu gỗ đồng bộ.', N'thanh', 45000, 90, 'sp_len_78.jpg', N'Đang kinh doanh', 'DM00000004'),
('SP00000013', N'Nẹp kết thúc chữ F', N'Phụ kiện nẹp kết thúc cho mép sàn.', N'thanh', 95000, 98, 'sp_nep_f.jpg', N'Đang kinh doanh', 'DM00000004'),
('SP00000014', N'Nẹp nối chữ T', N'Nẹp nối giữa hai mặt sàn khác cao độ.', N'thanh', 105000, 80, 'sp_nep_t.jpg', N'Đang kinh doanh', 'DM00000004'),
('SP00000015', N'Foam lót sàn 2mm', N'Lớp lót chống ẩm, giảm ồn cho sàn gỗ.', N'cuộn', 320000, 83, 'sp_foam_2mm.jpg', N'Đang kinh doanh', 'DM00000004'),
('SP00000016', N'Keo silicone trung tính', N'Keo hoàn thiện cho các điểm tiếp giáp.', N'chai', 85000, 70, 'sp_keo_silicone.jpg', N'Đang kinh doanh', 'DM00000004'),
('SP00000017', N'Tấm ốp lam sóng 3 sóng', N'Ốp trang trí phòng khách, phòng ngủ.', N'tấm', 185000, 118, 'sp_lamsong_3song.jpg', N'Đang kinh doanh', 'DM00000005'),
('SP00000018', N'Tấm ốp lam sóng 4 sóng', N'Mẫu lam sóng bản rộng cho mảng tường lớn.', N'tấm', 225000, 120, 'sp_lamsong_4song.jpg', N'Đang kinh doanh', 'DM00000005'),
('SP00000019', N'Tấm than tre vân gỗ', N'Tấm ốp than tre chống ẩm, dễ vệ sinh.', N'tấm', 265000, 60, 'sp_than_tre_vango.jpg', N'Đang kinh doanh', 'DM00000005'),
('SP00000020', N'Tấm PVC giả đá', N'Tấm ốp tường nhẹ, thi công nhanh.', N'tấm', 245000, 70, 'sp_pvc_giada.jpg', N'Đang kinh doanh', 'DM00000005');

INSERT INTO GIOHANG (MaGioHang, NgayTao, TrangThai, MaKhachHang) VALUES
('GH00000001', '2026-04-02 10:03:00', N'Đã chuyển đơn', 'KH00000001'),
('GH00000002', '2026-04-03 10:06:00', N'Đã chuyển đơn', 'KH00000002'),
('GH00000003', '2026-04-04 10:09:00', N'Đã chuyển đơn', 'KH00000003'),
('GH00000004', '2026-04-05 10:12:00', N'Đã chuyển đơn', 'KH00000004'),
('GH00000005', '2026-04-06 10:15:00', N'Đã chuyển đơn', 'KH00000005'),
('GH00000006', '2026-04-07 10:18:00', N'Đã chuyển đơn', 'KH00000006'),
('GH00000007', '2026-04-08 10:21:00', N'Đã chuyển đơn', 'KH00000007'),
('GH00000008', '2026-04-09 10:24:00', N'Đã chuyển đơn', 'KH00000008'),
('GH00000009', '2026-04-10 10:27:00', N'Đã chuyển đơn', 'KH00000009'),
('GH00000010', '2026-04-11 10:30:00', N'Đã chuyển đơn', 'KH00000010'),
('GH00000011', '2026-04-12 10:33:00', N'Đã chuyển đơn', 'KH00000011'),
('GH00000012', '2026-04-13 10:36:00', N'Đã chuyển đơn', 'KH00000012'),
('GH00000013', '2026-04-14 10:39:00', N'Đã chuyển đơn', 'KH00000013'),
('GH00000014', '2026-04-01 10:42:00', N'Đã chuyển đơn', 'KH00000014'),
('GH00000015', '2026-04-02 10:45:00', N'Đã chuyển đơn', 'KH00000015'),
('GH00000016', '2026-04-03 10:48:00', N'Đang hoạt động', 'KH00000016'),
('GH00000017', '2026-04-04 10:51:00', N'Đang hoạt động', 'KH00000017'),
('GH00000018', '2026-04-05 10:54:00', N'Đang hoạt động', 'KH00000018'),
('GH00000019', '2026-04-06 10:57:00', N'Đang hoạt động', 'KH00000019'),
('GH00000020', '2026-04-07 10:00:00', N'Đang hoạt động', 'KH00000020');

INSERT INTO CHITIETGIOHANG (MaGioHang, MaSanPham, SoLuong, DonGiaTaiThoiDiemThem, ThanhTienTamTinh) VALUES
('GH00000001', 'SP00000001', 18, 285000, 5130000),
('GH00000002', 'SP00000002', 15, 465000, 6975000),
('GH00000003', 'SP00000003', 20, 520000, 10400000),
('GH00000004', 'SP00000004', 16, 680000, 10880000),
('GH00000005', 'SP00000005', 22, 225000, 4950000),
('GH00000006', 'SP00000006', 14, 295000, 4130000),
('GH00000007', 'SP00000007', 25, 335000, 8375000),
('GH00000008', 'SP00000008', 12, 390000, 4680000),
('GH00000009', 'SP00000009', 30, 645000, 19350000),
('GH00000010', 'SP00000010', 18, 760000, 13680000),
('GH00000011', 'SP00000011', 10, 185000, 1850000),
('GH00000012', 'SP00000012', 28, 45000, 1260000),
('GH00000013', 'SP00000013', 16, 95000, 1520000),
('GH00000014', 'SP00000014', 24, 105000, 2520000),
('GH00000015', 'SP00000015', 8, 320000, 2560000),
('GH00000016', 'SP00000016', 20, 85000, 1700000),
('GH00000017', 'SP00000017', 14, 185000, 2590000),
('GH00000018', 'SP00000018', 12, 225000, 2700000),
('GH00000019', 'SP00000019', 18, 265000, 4770000),
('GH00000020', 'SP00000020', 10, 245000, 2450000);

INSERT INTO DONHANG (MaDonHang, NgayDat, TongTien, TrangThai, DiaChiGiaoHang, SoDienThoaiNhanHang, GhiChu, MaKhachHang) VALUES
('DH00000001', '2026-01-05 09:15:00', 7125000, N'Hoàn tất', N'12 Nguyễn Hữu Cảnh, Bình Thạnh, TP.HCM', '0912345601', N'Giao giờ hành chính', 'KH00000001'),
('DH00000002', '2026-01-08 14:20:00', 8370000, N'Hoàn tất', N'45 Lê Văn Việt, TP. Thủ Đức, TP.HCM', '0912345602', N'Yêu cầu xuất hóa đơn', 'KH00000002'),
('DH00000003', '2026-01-12 10:00:00', 7800000, N'Hoàn tất', N'88 Nguyễn Thị Thập, Quận 7, TP.HCM', '0912345603', N'Liên hệ trước khi giao', 'KH00000003'),
('DH00000004', '2026-01-18 16:35:00', 8160000, N'Hoàn tất', N'102 Phan Văn Trị, Gò Vấp, TP.HCM', '0912345604', N'', 'KH00000004'),
('DH00000005', '2026-01-22 11:10:00', 10600000, N'Hoàn tất', N'36 Trần Não, TP. Thủ Đức, TP.HCM', '0912345605', N'Công trình cải tạo showroom', 'KH00000005'),
('DH00000006', '2026-02-02 08:45:00', 6490000, N'Đang giao', N'14 Võ Văn Kiệt, Quận 1, TP.HCM', '0912345606', N'Giao tại công trình', 'KH00000006'),
('DH00000007', '2026-02-06 13:30:00', 6700000, N'Đang giao', N'71 Tên Lửa, Bình Tân, TP.HCM', '0912345607', N'', 'KH00000007'),
('DH00000008', '2026-02-11 15:00:00', 12160000, N'Đã xác nhận', N'209 Kha Vạn Cân, TP. Thủ Đức, TP.HCM', '0912345608', N'Chốt mẫu màu Dark', 'KH00000008'),
('DH00000009', '2026-02-15 09:05:00', 5550000, N'Đã xác nhận', N'55 Phổ Quang, Tân Bình, TP.HCM', '0912345609', N'Khách tự nhận hàng phụ kiện', 'KH00000009'),
('DH00000010', '2026-02-20 17:20:00', 11610000, N'Hoàn tất', N'28 Âu Cơ, Tân Phú, TP.HCM', '0912345610', N'', 'KH00000010'),
('DH00000011', '2026-03-01 10:40:00', 5850000, N'Chờ xác nhận', N'64 Nguyễn Xí, Bình Thạnh, TP.HCM', '0912345611', N'Đặt qua hotline', 'KH00000011'),
('DH00000012', '2026-03-04 14:15:00', 2700000, N'Đã xác nhận', N'90 D2, Bình Thạnh, TP.HCM', '0912345612', N'Xuất kho trong tuần', 'KH00000012'),
('DH00000013', '2026-03-09 11:25:00', 5460000, N'Hoàn tất', N'123 Huỳnh Tấn Phát, Quận 7, TP.HCM', '0912345613', N'', 'KH00000013'),
('DH00000014', '2026-03-12 09:55:00', 4070000, N'Đang xử lý', N'18 Song Hành, TP. Thủ Đức, TP.HCM', '0912345614', N'Khách cần giữ hàng 3 ngày', 'KH00000014'),
('DH00000015', '2026-03-18 16:10:00', 4900000, N'Hoàn tất', N'41 Cộng Hòa, Tân Bình, TP.HCM', '0912345615', N'Xuất hóa đơn công ty', 'KH00000015'),
('DH00000016', '2026-03-22 08:20:00', 4050000, N'Đã hủy', N'77 Quốc Hương, TP. Thủ Đức, TP.HCM', '0912345616', N'Khách đổi phương án vật liệu', 'KH00000016'),
('DH00000017', '2026-03-25 13:50:00', 3840000, N'Chờ xác nhận', N'135 Lũy Bán Bích, Tân Phú, TP.HCM', '0912345617', N'', 'KH00000017'),
('DH00000018', '2026-03-28 10:30:00', 4200000, N'Hoàn tất', N'222 Phạm Văn Đồng, Gò Vấp, TP.HCM', '0912345618', N'Giao ngoài giờ hành chính', 'KH00000018'),
('DH00000019', '2026-04-02 15:45:00', 3040000, N'Đang giao', N'39 Nguyễn Văn Linh, Quận 7, TP.HCM', '0912345619', N'Ưu tiên giao sáng', 'KH00000019'),
('DH00000020', '2026-04-07 09:40:00', 1275000, N'Đã xác nhận', N'66 Điện Biên Phủ, Bình Thạnh, TP.HCM', '0912345620', N'Khách nhận mẫu trước khi giao đủ', 'KH00000020');

INSERT INTO CHITIETDONHANG (MaDonHang, MaSanPham, SoLuong, DonGia, ThanhTien, GhiChu) VALUES
('DH00000001', 'SP00000001', 25, 285000, 7125000, N''),
('DH00000002', 'SP00000002', 18, 465000, 8370000, N''),
('DH00000003', 'SP00000003', 15, 520000, 7800000, N''),
('DH00000004', 'SP00000004', 12, 680000, 8160000, N''),
('DH00000005', 'SP00000019', 40, 265000, 10600000, N''),
('DH00000006', 'SP00000006', 22, 295000, 6490000, N''),
('DH00000007', 'SP00000007', 20, 335000, 6700000, N''),
('DH00000008', 'SP00000010', 16, 760000, 12160000, N''),
('DH00000009', 'SP00000011', 30, 185000, 5550000, N''),
('DH00000010', 'SP00000009', 18, 645000, 11610000, N''),
('DH00000011', 'SP00000005', 26, 225000, 5850000, N''),
('DH00000012', 'SP00000012', 60, 45000, 2700000, N''),
('DH00000013', 'SP00000008', 14, 390000, 5460000, N''),
('DH00000014', 'SP00000017', 22, 185000, 4070000, N''),
('DH00000015', 'SP00000020', 20, 245000, 4900000, N''),
('DH00000016', 'SP00000018', 18, 225000, 4050000, N''),
('DH00000017', 'SP00000015', 12, 320000, 3840000, N''),
('DH00000018', 'SP00000014', 40, 105000, 4200000, N''),
('DH00000019', 'SP00000013', 32, 95000, 3040000, N''),
('DH00000020', 'SP00000016', 15, 85000, 1275000, N'');

INSERT INTO THANHTOAN (MaThanhToan, PhuongThucThanhToan, SoTien, TrangThai, NgayThanhToan, GhiChu, MaDonHang, MaNhanVien) VALUES
('TT00000001', N'Chuyển khoản', 7125000, N'Đã thanh toán', '2026-01-07 09:15:00', N'Đã đối soát thanh toán thành công', 'DH00000001', 'NV00000003'),
('TT00000002', N'Thanh toán khi nhận hàng', 8370000, N'Đã thanh toán', '2026-01-10 14:20:00', N'Thu tiền khi giao hàng thành công', 'DH00000002', 'NV00000003'),
('TT00000003', N'Thanh toán khi nhận hàng', 7800000, N'Đã thanh toán', '2026-01-14 10:00:00', N'Thu tiền khi giao hàng thành công', 'DH00000003', 'NV00000003'),
('TT00000004', N'Chuyển khoản', 8160000, N'Đã thanh toán', '2026-01-20 16:35:00', N'Đã đối soát thanh toán thành công', 'DH00000004', 'NV00000003'),
('TT00000005', N'Chuyển khoản', 10600000, N'Đã thanh toán', '2026-01-24 11:10:00', N'Đã đối soát thanh toán thành công', 'DH00000005', 'NV00000003'),
('TT00000006', N'Thanh toán khi nhận hàng', 6490000, N'Chưa thanh toán', NULL, N'Đơn đang giao, chờ hoàn tất thanh toán', 'DH00000006', 'NV00000003'),
('TT00000007', N'Thanh toán khi nhận hàng', 6700000, N'Chưa thanh toán', NULL, N'Đơn đang giao, chờ hoàn tất thanh toán', 'DH00000007', 'NV00000003'),
('TT00000008', N'Chuyển khoản', 12160000, N'Chờ xác nhận thanh toán', NULL, N'Đơn đang trong quá trình xử lý thanh toán', 'DH00000008', 'NV00000003'),
('TT00000009', N'Chuyển khoản', 5550000, N'Chờ xác nhận thanh toán', NULL, N'Đơn đang trong quá trình xử lý thanh toán', 'DH00000009', 'NV00000003'),
('TT00000010', N'Chuyển khoản', 11610000, N'Đã thanh toán', '2026-02-22 17:20:00', N'Đã đối soát thanh toán thành công', 'DH00000010', 'NV00000003'),
('TT00000011', N'Chưa chọn', 5850000, N'Chưa thanh toán', NULL, N'Đơn đang trong quá trình xử lý thanh toán', 'DH00000011', 'NV00000003'),
('TT00000012', N'Chuyển khoản', 2700000, N'Chờ xác nhận thanh toán', NULL, N'Đơn đang trong quá trình xử lý thanh toán', 'DH00000012', 'NV00000003'),
('TT00000013', N'Chuyển khoản', 5460000, N'Đã thanh toán', '2026-03-11 11:25:00', N'Đã đối soát thanh toán thành công', 'DH00000013', 'NV00000003'),
('TT00000014', N'Chưa chọn', 4070000, N'Chưa thanh toán', NULL, N'Đơn đang trong quá trình xử lý thanh toán', 'DH00000014', 'NV00000003'),
('TT00000015', N'Thanh toán khi nhận hàng', 4900000, N'Đã thanh toán', '2026-03-20 16:10:00', N'Thu tiền khi giao hàng thành công', 'DH00000015', 'NV00000003'),
('TT00000016', N'Chưa chọn', 4050000, N'Đã hủy', NULL, N'Đơn hàng đã hủy trước khi thanh toán', 'DH00000016', 'NV00000003'),
('TT00000017', N'Chưa chọn', 3840000, N'Chưa thanh toán', NULL, N'Đơn đang trong quá trình xử lý thanh toán', 'DH00000017', 'NV00000003'),
('TT00000018', N'Chuyển khoản', 4200000, N'Đã thanh toán', '2026-03-30 10:30:00', N'Đã đối soát thanh toán thành công', 'DH00000018', 'NV00000003'),
('TT00000019', N'Thanh toán khi nhận hàng', 3040000, N'Chưa thanh toán', NULL, N'Đơn đang giao, chờ hoàn tất thanh toán', 'DH00000019', 'NV00000003'),
('TT00000020', N'Chuyển khoản', 1275000, N'Chờ xác nhận thanh toán', NULL, N'Đơn đang trong quá trình xử lý thanh toán', 'DH00000020', 'NV00000003');

INSERT INTO HOADON (MaHoaDon, NgayLap, TongTien, TrangThaiThanhToan, ThueVAT, MaSoThue, DiaChiXuatHoaDon, MaDonHang, MaNhanVien) VALUES
('HD00000001', '2026-01-08 09:15:00', 7125000, N'Đã thanh toán', 8.0, '', N'12 Nguyễn Hữu Cảnh, Bình Thạnh, TP.HCM', 'DH00000001', 'NV00000003'),
('HD00000002', '2026-01-11 14:20:00', 8370000, N'Đã thanh toán', 8.0, '0312300002', N'45 Lê Văn Việt, TP. Thủ Đức, TP.HCM', 'DH00000002', 'NV00000003'),
('HD00000003', '2026-01-15 10:00:00', 7800000, N'Đã thanh toán', 8.0, '', N'88 Nguyễn Thị Thập, Quận 7, TP.HCM', 'DH00000003', 'NV00000003'),
('HD00000004', '2026-01-21 16:35:00', 8160000, N'Đã thanh toán', 8.0, '', N'102 Phan Văn Trị, Gò Vấp, TP.HCM', 'DH00000004', 'NV00000003'),
('HD00000005', '2026-01-25 11:10:00', 10600000, N'Đã thanh toán', 8.0, '0312300005', N'36 Trần Não, TP. Thủ Đức, TP.HCM', 'DH00000005', 'NV00000003'),
('HD00000006', '2026-02-05 08:45:00', 6490000, N'Chưa thanh toán', 8.0, '', N'14 Võ Văn Kiệt, Quận 1, TP.HCM', 'DH00000006', 'NV00000003'),
('HD00000007', '2026-02-09 13:30:00', 6700000, N'Chưa thanh toán', 8.0, '', N'71 Tên Lửa, Bình Tân, TP.HCM', 'DH00000007', 'NV00000003'),
('HD00000008', '2026-02-14 15:00:00', 12160000, N'Chưa thanh toán', 8.0, '', N'209 Kha Vạn Cân, TP. Thủ Đức, TP.HCM', 'DH00000008', 'NV00000003'),
('HD00000009', '2026-02-18 09:05:00', 5550000, N'Chưa thanh toán', 8.0, '', N'55 Phổ Quang, Tân Bình, TP.HCM', 'DH00000009', 'NV00000003'),
('HD00000010', '2026-02-23 17:20:00', 11610000, N'Đã thanh toán', 8.0, '0312300010', N'28 Âu Cơ, Tân Phú, TP.HCM', 'DH00000010', 'NV00000003'),
('HD00000011', '2026-03-04 10:40:00', 5850000, N'Chưa thanh toán', 8.0, '', N'64 Nguyễn Xí, Bình Thạnh, TP.HCM', 'DH00000011', 'NV00000003'),
('HD00000012', '2026-03-07 14:15:00', 2700000, N'Chưa thanh toán', 8.0, '', N'90 D2, Bình Thạnh, TP.HCM', 'DH00000012', 'NV00000003'),
('HD00000013', '2026-03-12 11:25:00', 5460000, N'Đã thanh toán', 8.0, '', N'123 Huỳnh Tấn Phát, Quận 7, TP.HCM', 'DH00000013', 'NV00000003'),
('HD00000014', '2026-03-15 09:55:00', 4070000, N'Chưa thanh toán', 8.0, '', N'18 Song Hành, TP. Thủ Đức, TP.HCM', 'DH00000014', 'NV00000003'),
('HD00000015', '2026-03-21 16:10:00', 4900000, N'Đã thanh toán', 8.0, '0312300015', N'41 Cộng Hòa, Tân Bình, TP.HCM', 'DH00000015', 'NV00000003'),
('HD00000016', '2026-03-25 08:20:00', 4050000, N'Chưa thanh toán', 8.0, '', N'77 Quốc Hương, TP. Thủ Đức, TP.HCM', 'DH00000016', 'NV00000003'),
('HD00000017', '2026-03-28 13:50:00', 3840000, N'Chưa thanh toán', 8.0, '', N'135 Lũy Bán Bích, Tân Phú, TP.HCM', 'DH00000017', 'NV00000003'),
('HD00000018', '2026-03-31 10:30:00', 4200000, N'Đã thanh toán', 8.0, '', N'222 Phạm Văn Đồng, Gò Vấp, TP.HCM', 'DH00000018', 'NV00000003'),
('HD00000019', '2026-04-05 15:45:00', 3040000, N'Chưa thanh toán', 8.0, '', N'39 Nguyễn Văn Linh, Quận 7, TP.HCM', 'DH00000019', 'NV00000003'),
('HD00000020', '2026-04-10 09:40:00', 1275000, N'Chưa thanh toán', 8.0, '0312300020', N'66 Điện Biên Phủ, Bình Thạnh, TP.HCM', 'DH00000020', 'NV00000003');

INSERT INTO PHIEUNHAPKHO (MaPhieuNhap, NgayNhap, TongSoLuong, TongTienNhap, NhaCungCap, GhiChu, TrangThai, MaNhanVien) VALUES
('PN00000001', '2026-01-03 08:30:00', 120, 23256000.0, N'Công ty Gỗ Việt Phát', N'Nhập hàng theo kế hoạch tồn kho đầu kỳ', N'Đã nhập', 'NV00000002'),
('PN00000002', '2026-01-05 08:30:00', 80, 25296000.0, N'Công ty Vật liệu Nội thất An Phú', N'Nhập hàng theo kế hoạch tồn kho đầu kỳ', N'Đã nhập', 'NV00000007'),
('PN00000003', '2026-01-07 08:30:00', 70, 24752000.0, N'Công ty WPC Green Deck', N'Nhập hàng theo kế hoạch tồn kho đầu kỳ', N'Đã nhập', 'NV00000012'),
('PN00000004', '2026-01-09 08:30:00', 60, 27744000.0, N'Công ty Phụ kiện Sàn Hoàng Gia', N'Nhập hàng theo kế hoạch tồn kho đầu kỳ', N'Đã nhập', 'NV00000017'),
('PN00000005', '2026-01-11 08:30:00', 200, 30600000.0, N'Công ty Trang trí Nội thất Minh Khang', N'Nhập hàng theo kế hoạch tồn kho đầu kỳ', N'Đã nhập', 'NV00000002'),
('PN00000006', '2026-01-13 08:30:00', 180, 36108000.0, N'Công ty Gỗ Việt Phát', N'Nhập hàng theo kế hoạch tồn kho đầu kỳ', N'Đã nhập', 'NV00000007'),
('PN00000007', '2026-01-15 08:30:00', 160, 36448000.0, N'Công ty Vật liệu Nội thất An Phú', N'Nhập hàng theo kế hoạch tồn kho đầu kỳ', N'Đã nhập', 'NV00000012'),
('PN00000008', '2026-02-17 08:30:00', 90, 23868000.0, N'Công ty WPC Green Deck', N'Nhập hàng theo kế hoạch tồn kho đầu kỳ', N'Đã nhập', 'NV00000017'),
('PN00000009', '2026-02-19 08:30:00', 75, 32895000.0, N'Công ty Phụ kiện Sàn Hoàng Gia', N'Nhập hàng theo kế hoạch tồn kho đầu kỳ', N'Đã nhập', 'NV00000002'),
('PN00000010', '2026-02-21 08:30:00', 65, 33592000.0, N'Công ty Trang trí Nội thất Minh Khang', N'Nhập hàng theo kế hoạch tồn kho đầu kỳ', N'Đã nhập', 'NV00000007'),
('PN00000011', '2026-02-23 08:30:00', 110, 13838000.0, N'Công ty Gỗ Việt Phát', N'Nhập hàng theo kế hoạch tồn kho đầu kỳ', N'Đã nhập', 'NV00000012'),
('PN00000012', '2026-02-25 08:30:00', 150, 4590000.0, N'Công ty Vật liệu Nội thất An Phú', N'Nhập hàng theo kế hoạch tồn kho đầu kỳ', N'Đã nhập', 'NV00000017'),
('PN00000013', '2026-02-27 08:30:00', 130, 8398000.0, N'Công ty WPC Green Deck', N'Nhập hàng theo kế hoạch tồn kho đầu kỳ', N'Đã nhập', 'NV00000002'),
('PN00000014', '2026-02-02 08:30:00', 120, 8568000.0, N'Công ty Phụ kiện Sàn Hoàng Gia', N'Nhập hàng theo kế hoạch tồn kho đầu kỳ', N'Đã nhập', 'NV00000007'),
('PN00000015', '2026-03-04 08:30:00', 95, 20672000.0, N'Công ty Trang trí Nội thất Minh Khang', N'Nhập hàng theo kế hoạch tồn kho đầu kỳ', N'Đã nhập', 'NV00000012'),
('PN00000016', '2026-03-06 08:30:00', 85, 4913000.0, N'Công ty Gỗ Việt Phát', N'Nhập hàng theo kế hoạch tồn kho đầu kỳ', N'Đã nhập', 'NV00000017'),
('PN00000017', '2026-03-08 08:30:00', 140, 17612000.0, N'Công ty Vật liệu Nội thất An Phú', N'Nhập hàng theo kế hoạch tồn kho đầu kỳ', N'Đã nhập', 'NV00000002'),
('PN00000018', '2026-03-10 08:30:00', 120, 18360000.0, N'Công ty WPC Green Deck', N'Nhập hàng theo kế hoạch tồn kho đầu kỳ', N'Đã nhập', 'NV00000007'),
('PN00000019', '2026-03-12 08:30:00', 100, 18020000.0, N'Công ty Phụ kiện Sàn Hoàng Gia', N'Nhập hàng theo kế hoạch tồn kho đầu kỳ', N'Đã nhập', 'NV00000012'),
('PN00000020', '2026-03-14 08:30:00', 90, 14994000.0, N'Công ty Trang trí Nội thất Minh Khang', N'Nhập hàng theo kế hoạch tồn kho đầu kỳ', N'Đã nhập', 'NV00000017');

INSERT INTO CHITIETPHIEUNHAP (MaPhieuNhap, MaSanPham, SoLuongNhap, DonGiaNhap, ThanhTienNhap) VALUES
('PN00000001', 'SP00000001', 120, 193800.0, 23256000.0),
('PN00000002', 'SP00000002', 80, 316200.0, 25296000.0),
('PN00000003', 'SP00000003', 70, 353600.0, 24752000.0),
('PN00000004', 'SP00000004', 60, 462400.0, 27744000.0),
('PN00000005', 'SP00000005', 200, 153000.0, 30600000.0),
('PN00000006', 'SP00000006', 180, 200600.0, 36108000.0),
('PN00000007', 'SP00000007', 160, 227800.0, 36448000.0),
('PN00000008', 'SP00000008', 90, 265200.0, 23868000.0),
('PN00000009', 'SP00000009', 75, 438600.0, 32895000.0),
('PN00000010', 'SP00000010', 65, 516800.0, 33592000.0),
('PN00000011', 'SP00000011', 110, 125800.0, 13838000.0),
('PN00000012', 'SP00000012', 150, 30600.0, 4590000.0),
('PN00000013', 'SP00000013', 130, 64600.0, 8398000.0),
('PN00000014', 'SP00000014', 120, 71400.0, 8568000.0),
('PN00000015', 'SP00000015', 95, 217600.0, 20672000.0),
('PN00000016', 'SP00000016', 85, 57800.0, 4913000.0),
('PN00000017', 'SP00000017', 140, 125800.0, 17612000.0),
('PN00000018', 'SP00000018', 120, 153000.0, 18360000.0),
('PN00000019', 'SP00000019', 100, 180200.0, 18020000.0),
('PN00000020', 'SP00000020', 90, 166600.0, 14994000.0);

INSERT INTO PHIEUXUATKHO (MaPhieuXuat, NgayXuat, TongSoLuong, GhiChu, TrangThai, MaDonHang, MaNhanVien) VALUES
('PX00000001', '2026-01-05 09:15:00', 25, N'Xuất kho theo đơn hàng', N'Đã xuất kho', 'DH00000001', 'NV00000002'),
('PX00000002', '2026-01-08 14:20:00', 18, N'Xuất kho theo đơn hàng', N'Đã xuất kho', 'DH00000002', 'NV00000007'),
('PX00000003', '2026-01-12 10:00:00', 15, N'Xuất kho theo đơn hàng', N'Đã xuất kho', 'DH00000003', 'NV00000012'),
('PX00000004', '2026-01-18 16:35:00', 12, N'Xuất kho theo đơn hàng', N'Đã xuất kho', 'DH00000004', 'NV00000017'),
('PX00000005', '2026-01-22 11:10:00', 40, N'Xuất kho theo đơn hàng', N'Đã xuất kho', 'DH00000005', 'NV00000002'),
('PX00000006', '2026-02-02 08:45:00', 22, N'Xuất kho theo đơn hàng', N'Đã xuất kho', 'DH00000006', 'NV00000007'),
('PX00000007', '2026-02-06 13:30:00', 20, N'Xuất kho theo đơn hàng', N'Đã xuất kho', 'DH00000007', 'NV00000012'),
('PX00000008', '2026-02-11 15:00:00', 16, N'Xuất kho theo đơn hàng', N'Đã lập phiếu', 'DH00000008', 'NV00000017'),
('PX00000009', '2026-02-15 09:05:00', 30, N'Xuất kho theo đơn hàng', N'Đã lập phiếu', 'DH00000009', 'NV00000002'),
('PX00000010', '2026-02-20 17:20:00', 18, N'Xuất kho theo đơn hàng', N'Đã xuất kho', 'DH00000010', 'NV00000007'),
('PX00000011', '2026-03-01 10:40:00', 26, N'Phiếu xuất hủy theo đơn hủy', N'Đã hủy', 'DH00000011', 'NV00000012'),
('PX00000012', '2026-03-04 14:15:00', 60, N'Xuất kho theo đơn hàng', N'Đã lập phiếu', 'DH00000012', 'NV00000017'),
('PX00000013', '2026-03-09 11:25:00', 14, N'Xuất kho theo đơn hàng', N'Đã xuất kho', 'DH00000013', 'NV00000002'),
('PX00000014', '2026-03-12 09:55:00', 22, N'Xuất kho theo đơn hàng', N'Đã lập phiếu', 'DH00000014', 'NV00000007'),
('PX00000015', '2026-03-18 16:10:00', 20, N'Xuất kho theo đơn hàng', N'Đã xuất kho', 'DH00000015', 'NV00000012'),
('PX00000016', '2026-03-22 08:20:00', 18, N'Phiếu xuất hủy theo đơn hủy', N'Đã hủy', 'DH00000016', 'NV00000017'),
('PX00000017', '2026-03-25 13:50:00', 12, N'Phiếu xuất hủy theo đơn hủy', N'Đã hủy', 'DH00000017', 'NV00000002'),
('PX00000018', '2026-03-28 10:30:00', 40, N'Xuất kho theo đơn hàng', N'Đã xuất kho', 'DH00000018', 'NV00000007'),
('PX00000019', '2026-04-02 15:45:00', 32, N'Xuất kho theo đơn hàng', N'Đã xuất kho', 'DH00000019', 'NV00000012'),
('PX00000020', '2026-04-07 09:40:00', 15, N'Xuất kho theo đơn hàng', N'Đã lập phiếu', 'DH00000020', 'NV00000017');

INSERT INTO CHITIETPHIEUXUAT (MaPhieuXuat, MaSanPham, SoLuongXuat, GhiChu) VALUES
('PX00000001', 'SP00000001', 25, N''),
('PX00000002', 'SP00000002', 18, N''),
('PX00000003', 'SP00000003', 15, N''),
('PX00000004', 'SP00000004', 12, N''),
('PX00000005', 'SP00000019', 40, N''),
('PX00000006', 'SP00000006', 22, N''),
('PX00000007', 'SP00000007', 20, N''),
('PX00000008', 'SP00000010', 16, N''),
('PX00000009', 'SP00000011', 30, N''),
('PX00000010', 'SP00000009', 18, N''),
('PX00000011', 'SP00000005', 26, N'Không thực xuất do đơn bị hủy'),
('PX00000012', 'SP00000012', 60, N''),
('PX00000013', 'SP00000008', 14, N''),
('PX00000014', 'SP00000017', 22, N''),
('PX00000015', 'SP00000020', 20, N''),
('PX00000016', 'SP00000018', 18, N'Không thực xuất do đơn bị hủy'),
('PX00000017', 'SP00000015', 12, N'Không thực xuất do đơn bị hủy'),
('PX00000018', 'SP00000014', 40, N''),
('PX00000019', 'SP00000013', 32, N''),
('PX00000020', 'SP00000016', 15, N'');

INSERT INTO KHUYENMAI (MaKhuyenMai, TenKhuyenMai, GiaTri, NgayBatDau, NgayKetThuc, DieuKienApDung, MoTa, TrangThai) VALUES
('KM00000001', N'Khuyến mãi sàn gỗ công nghiệp tháng 3', 10.0, '2026-03-01', '2026-03-31', N'Áp dụng cho nhóm sàn gỗ công nghiệp từ 20 m2', N'Giảm trực tiếp 10% cho đơn hàng công nghiệp đủ điều kiện', N'Hết hiệu lực'),
('KM00000002', N'Ưu đãi phụ kiện đồng bộ', 5.0, '2026-02-15', '2026-04-30', N'Áp dụng khi mua kèm sàn gỗ', N'Giảm 5% cho một số phụ kiện đi kèm đơn hàng sàn gỗ', N'Đang áp dụng'),
('KM00000003', N'Khai trương dòng ốp than tre', 8.0, '2026-04-01', '2026-05-15', N'Áp dụng cho tấm ốp than tre', N'Giảm 8% cho sản phẩm mới ra mắt', N'Đang áp dụng'),
('KM00000004', N'Ưu đãi sàn ngoài trời quý I', 7.0, '2026-01-10', '2026-03-20', N'Áp dụng cho nhóm sàn ngoài trời từ 15 m2', N'Khuyến mãi nhóm WPC và vỉ gỗ ngoài trời', N'Hết hiệu lực'),
('KM00000005', N'Khuyến mãi khách hàng doanh nghiệp', 12.0, '2026-04-05', '2026-06-30', N'Áp dụng cho đơn có xuất hóa đơn doanh nghiệp', N'Ưu đãi cho khách công ty, showroom, văn phòng', N'Đang áp dụng');

INSERT INTO SANPHAM_KHUYENMAI (MaSanPham, MaKhuyenMai) VALUES
('SP00000005', 'KM00000001'),
('SP00000006', 'KM00000001'),
('SP00000015', 'KM00000002'),
('SP00000019', 'KM00000003'),
('SP00000010', 'KM00000004');

INSERT INTO BAOCAO (MaBaoCao, TenBaoCao, NgayLap, NoiDung, LoaiBaoCao, TuNgay, DenNgay, MaNhanVien) VALUES
('BC00000001', N'Báo cáo doanh thu tháng 01/2026', '2026-02-01 08:30:00', N'Tổng hợp doanh thu bán hàng tháng 01/2026 theo đơn hàng hoàn tất.', N'Doanh thu', '2026-01-01', '2026-01-31', 'NV00000004'),
('BC00000002', N'Báo cáo tồn kho quý I/2026', '2026-04-01 09:00:00', N'Tổng hợp số lượng nhập xuất tồn của nhóm sàn gỗ và phụ kiện.', N'Tồn kho', '2026-01-01', '2026-03-31', 'NV00000009'),
('BC00000003', N'Báo cáo bán hàng theo sản phẩm', '2026-04-05 10:15:00', N'So sánh sản lượng bán giữa các nhóm sản phẩm chủ lực.', N'Bán hàng', '2026-01-01', '2026-04-04', 'NV00000014'),
('BC00000004', N'Báo cáo công nợ COD đang giao', '2026-04-08 14:00:00', N'Theo dõi các đơn hàng COD chưa thu tiền khi đang giao.', N'Công nợ', '2026-03-01', '2026-04-08', 'NV00000003'),
('BC00000005', N'Báo cáo hiệu quả khuyến mãi', '2026-04-10 16:20:00', N'Đánh giá sơ bộ hiệu quả các chương trình khuyến mãi đang áp dụng.', N'Khuyến mãi', '2026-03-01', '2026-04-10', 'NV00000019');


SELECT * FROM DANHMUCSANPHAM ORDER BY MaDanhMuc;
SELECT * FROM KHUYENMAI ORDER BY MaKhuyenMai;
SELECT * FROM SANPHAM_KHUYENMAI ORDER BY MaSanPham, MaKhuyenMai;
SELECT * FROM BAOCAO ORDER BY MaBaoCao;

SELECT * FROM TAIKHOAN ORDER BY MaTaiKhoan;
SELECT * FROM KHACHHANG ORDER BY MaKhachHang;
SELECT * FROM NHANVIEN ORDER BY MaNhanVien;
SELECT * FROM SANPHAM ORDER BY MaSanPham;
SELECT * FROM GIOHANG ORDER BY MaGioHang;
SELECT * FROM CHITIETGIOHANG ORDER BY MaGioHang, MaSanPham;
SELECT * FROM DONHANG ORDER BY MaDonHang;
SELECT * FROM CHITIETDONHANG ORDER BY MaDonHang, MaSanPham;
SELECT * FROM THANHTOAN ORDER BY MaThanhToan;
SELECT * FROM HOADON ORDER BY MaHoaDon;
SELECT * FROM PHIEUNHAPKHO ORDER BY MaPhieuNhap;
SELECT * FROM CHITIETPHIEUNHAP ORDER BY MaPhieuNhap, MaSanPham;
SELECT * FROM PHIEUXUATKHO ORDER BY MaPhieuXuat;
SELECT * FROM CHITIETPHIEUXUAT ORDER BY MaPhieuXuat, MaSanPham;


--------------RÀNG BUỘC DỮ LIỆU------------------------
---RÀNG BUỘC 1---------
GO
CREATE TRIGGER TRG_RBTV1_KHACHHANG_TAIKHOAN_VAITRO
ON KHACHHANG
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN TAIKHOAN tk ON i.MaTaiKhoan = tk.MaTaiKhoan
        WHERE tk.VaiTro <> N'Khách hàng'
    )
    BEGIN
        RAISERROR (N'RBTV1: Tài khoản gắn với khách hàng phải có vai trò "Khách hàng".', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
GO
----Kiểm tra hoạt động------
UPDATE KHACHHANG
SET MaTaiKhoan = 'TK00000021'
WHERE MaKhachHang = 'KH00000001';
-----------RÀNG BUỘC 2----------
GO
CREATE TRIGGER TRG_RBTV2_NHANVIEN_TAIKHOAN_VAITRO
ON NHANVIEN
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN TAIKHOAN tk ON i.MaTaiKhoan = tk.MaTaiKhoan
        WHERE i.ChucDanh <> tk.VaiTro
    )
    BEGIN
        RAISERROR (N'RBTV2: Vai trò tài khoản phải phù hợp với chức danh của nhân viên.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END;
GO

UPDATE NHANVIEN
SET MaTaiKhoan = CASE 
                    WHEN MaNhanVien = 'NV00000002' THEN 'TK00000023'
                    WHEN MaNhanVien = 'NV00000003' THEN 'TK00000022'
                 END
WHERE MaNhanVien IN ('NV00000002', 'NV00000003');


---------------------RÀNG BUỘC 3--------------
GO
CREATE TRIGGER TRG_RBTV3_KHACHHANG_NGAYDANGKY
ON KHACHHANG
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN TAIKHOAN tk ON i.MaTaiKhoan = tk.MaTaiKhoan
        WHERE i.NgayDangKy < tk.NgayTao
    )
    BEGIN
        RAISERROR (N'RBTV3: Ngày đăng ký khách hàng không được trước ngày tạo tài khoản.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

UPDATE KHACHHANG
SET NgayDangKy = '2024-01-01 08:00:00'
WHERE MaKhachHang = 'KH00000001';
------------------RÀNG BUỘC 4------------------
GO
CREATE TRIGGER TRG_RBTV4_CTGH_THANHTIEN
ON CHITIETGIOHANG
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE ThanhTienTamTinh <> SoLuong * DonGiaTaiThoiDiemThem
    )
    BEGIN
        RAISERROR (N'RBTV4: Thành tiền tạm tính giỏ hàng phải bằng số lượng nhân đơn giá.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

UPDATE CHITIETGIOHANG
SET ThanhTienTamTinh = 999999
WHERE MaGioHang = 'GH00000001'
  AND MaSanPham = 'SP00000001';

---------------RÀNG BUỘC 5---------------------
GO
CREATE TRIGGER TRG_RBTV5_CTDH_THANHTIEN
ON CHITIETDONHANG
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE ThanhTien <> SoLuong * DonGia
    )
    BEGIN
        RAISERROR (N'RBTV5: Thành tiền chi tiết đơn hàng phải bằng số lượng nhân đơn giá.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

UPDATE CHITIETDONHANG
SET ThanhTien = 1000000
WHERE MaDonHang = 'DH00000001'
  AND MaSanPham = 'SP00000001';

----------------RÀNG BUỘC 6------------------------
GO
CREATE TRIGGER TRG_RBTV6_DONHANG_TONGTIEN
ON DONHANG
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        CROSS APPLY (
            SELECT ISNULL(SUM(ct.ThanhTien), 0) AS TongChiTiet
            FROM CHITIETDONHANG ct
            WHERE ct.MaDonHang = i.MaDonHang
        ) x
        WHERE i.TongTien <> x.TongChiTiet
    )
    BEGIN
        RAISERROR (N'RBTV6: Tổng tiền đơn hàng phải bằng tổng thành tiền các chi tiết đơn hàng.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

UPDATE DONHANG
SET TongTien = 8000000
WHERE MaDonHang = 'DH00000001';

-------------------RÀNG BUỘC 7----------------
GO
CREATE TRIGGER TRG_RBTV7_THANHTOAN_SOTIEN
ON THANHTOAN
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN DONHANG dh ON i.MaDonHang = dh.MaDonHang
        WHERE i.SoTien <> dh.TongTien
    )
    BEGIN
        RAISERROR (N'RBTV7: Số tiền thanh toán phải bằng tổng tiền đơn hàng.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO


UPDATE THANHTOAN
SET SoTien = 7000000
WHERE MaThanhToan = 'TT00000001';

-----------------RÀNG BUỘC 8----------------
GO
CREATE TRIGGER TRG_RBTV8_THANHTOAN_TRANGTHAI
ON THANHTOAN
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE PhuongThucThanhToan = N'Chưa chọn'
          AND TrangThai NOT IN (N'Chưa thanh toán', N'Đã hủy')
    )
    BEGIN
        RAISERROR (N'RBTV8: Nếu chưa chọn phương thức thanh toán thì trạng thái chỉ được là "Chưa thanh toán" hoặc "Đã hủy".', 16, 1);
        ROLLBACK TRANSACTION;
    END

    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE TrangThai = N'Đã thanh toán'
          AND NgayThanhToan IS NULL
    )
    BEGIN
        RAISERROR (N'RBTV8: Thanh toán ở trạng thái "Đã thanh toán" bắt buộc phải có ngày thanh toán.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

UPDATE THANHTOAN
SET PhuongThucThanhToan = N'Chưa chọn',
    TrangThai = N'Đã thanh toán'
WHERE MaThanhToan = 'TT00000011';

--------------------RÀNG BUỘC 9-------------------
GO
CREATE TRIGGER TRG_RBTV9_HOADON_NGAYLAP
ON HOADON
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN DONHANG dh ON i.MaDonHang = dh.MaDonHang
        WHERE i.NgayLap < dh.NgayDat
    )
    BEGIN
        RAISERROR (N'RBTV9: Ngày lập hóa đơn không được trước ngày đặt hàng.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

UPDATE HOADON
SET NgayLap = '2025-12-31 08:00:00'
WHERE MaHoaDon = 'HD00000001';

-------------RÀNG BUỘC 10--------------
GO
CREATE TRIGGER TRG_RBTV10_CTPX_SOLUONGXUAT
ON CHITIETPHIEUXUAT
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN PHIEUXUATKHO px ON i.MaPhieuXuat = px.MaPhieuXuat
        LEFT JOIN CHITIETDONHANG ctdh
            ON px.MaDonHang = ctdh.MaDonHang
           AND i.MaSanPham = ctdh.MaSanPham
        WHERE ctdh.MaDonHang IS NULL
           OR i.SoLuongXuat > ctdh.SoLuong
    )
    BEGIN
        RAISERROR (N'RBTV10: Số lượng xuất kho không được vượt quá số lượng đặt trong đơn hàng.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

UPDATE CHITIETPHIEUXUAT
SET SoLuongXuat = 30
WHERE MaPhieuXuat = 'PX00000001'
  AND MaSanPham = 'SP00000001';