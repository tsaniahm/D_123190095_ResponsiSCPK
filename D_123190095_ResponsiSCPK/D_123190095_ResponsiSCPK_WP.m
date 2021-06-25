%PENYELESAIAN KASUS PENCARIAN ALTERNATIF REAL ESTATE TERBAIK
clc; %untuk membersihkan jendela command windows

%Melakukan Import dataset dari file berekstensi .xlsx
opts = detectImportOptions('Real estate valuation data set.xlsx');
opts.SelectedVariableNames = [3:5 8];
data = readmatrix('Real estate valuation data set.xlsx', opts);

x = data(1:50,:); format shortG; %data rating kecocokan dari masing-masing alternatif
k = [0,0,1,0]; %nilai atribut tiap kriteria,dgn nilai 1 sebagai benefit & 0 sebagai cost
w = [3,5,4,1]; %nilai bobot masing-masing kriteria

%TAHAP PERTAMA, perbaikan bobot
[m n]=size (x); %inisialisasi ukuran x
w=w./sum(w); %membagi bobot per kriteria dengan jumlah total keseluruh bobot

%TAHAP KEDUA, melakukan perhitungan vektor(S) per baris (alternatif)
for j=1:n,
    if k(j)==0, w(j)=-1*w(j);
    end;
end;
for i=1:m,
    S(i)=prod(x(i,:).^w);
end;

%TAHAP KETIGA, proses perangkingan
V= S/sum(S); %proses perankingan dengan membai per baris S dengan keseluruhan jumlah
[sd,r]=sort(V,'descend'); %proses pengurutan berdasarkan nilai vektor tertinggi
sd; %hasil vektor yang telah diurutkan
r; %index dari per nilai vektor yang telah diurutkan

%TAHAP KEEMPAT. proses menampilkan hasil perankingan ke dalam command
%window
disp('                      REAL ESTATE                      ') 
disp(' ----------------------------------------------------- ')
disp('| No |   Real Estate No    |   RANK    |    VEKTOR    |')
disp(' ----------------------------------------------------- ')

for i = 1:5,
    disp(['| ',num2str(i), blanks(3 - length(num2str(i))),'|', num2str(r(i)), blanks(20 - length(num2str(r(i)))), ' | ', ... 
        num2str(i), blanks(10 - length(num2str(i))), ' | ', ... 
        num2str(sd(i)), blanks(11 - length(num2str(sd(i)))), ' | '])
   disp(' ----------------------------------------------------- ')
end;


