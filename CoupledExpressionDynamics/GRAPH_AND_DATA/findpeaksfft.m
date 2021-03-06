function findpeaksfft(mat)

[wlA,avA] = findpeaksfftsub(mat(:,2),mat(:,1));
hold on
[wlR,avR] = findpeaksfftsub(mat(:,3),mat(:,1));

lagDiff = lagtime(mat(:,2),mat(:,3));
disp(mat(abs(lagDiff),1));

disp([avA avR]);

legend('A','R');

title(['Period A:' num2str(wlA) ', Period R:' num2str(wlR)])

function [wl,av] = findpeaksfftsub(A,distance)

av = mean(A);
r = 10;
y = interp(distance,r); % increase sampling frequency by r
y(y>max(distance)) = [];
y(1) = 0;

A = interp1(distance,A,y);
A = A-mean(A);
distance = y;

% Find wavelength of A
L = length(A);
if mod(L,2) ~= 0
    A = A(1:end-1,:);
end

Y = fft(A);
L = length(A);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

difft = diff(distance);
Fs = 1/difft(1);
f = Fs*(0:(L/2))/L;

[~,i]=max(P1);

wl = 1/f(i);

%     subplot(1,2,1)
%     plot(distance(1:length(A)),A)
%     xlabel('Length (um)', 'fontsize',14);
%     ylabel('EminDT');
%     subplot(1,2,2)
plot(1./f,P1,'LineWidth',3)
xlabel('Period (s)', 'fontsize',24);
ylabel('Magnitude', 'fontsize',24);
%     title(['Period ' num2str(wl)])
pause(0.1)
set(gcf,'color','w');
set(gca,'FontSize',24);
xlim([0 50]);
axis square

function lagDiff = lagtime(s1,s2)

[acor,lag] = xcorr(s2,s1);

[~,I] = max(abs(acor));
lagDiff = lag(I);