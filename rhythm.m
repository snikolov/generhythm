function rhythm

x = wavread('beat3.wav');
x = x(:,1);
size(x)
x = downsample(x, 100);
plot(x)

y = abs(x) > 0.1;
indices = 1:numel(y);
event_indices = indices(y);
plot(event_indices)

% Distribution of 1st order interarrivals.
for k = 1:100
  [intarr12_1, intarr12_2] = intarrkm(event_indices, k, 5);
  scatter(intarr12_1, intarr12_2, 'k', 'filled', 'SizeData', 5);
  % hist(intarrk(event_indices, k), 80)
  title(k)
  pause(0.1)
end

function intarr = intarrk(s, k)
intarr = s(k+1:end) - s(1:end - k);
intarr(intarr < 100) = [];

function [intarrk,intarrm] = intarrkm(s, k, m)
intarrk = s(k+1:end-m) - s(1:end-m-k);
intarrm = s(k+m+1:end) - s(k+1:end-m);
