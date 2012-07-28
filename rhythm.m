function rhythm

x = wavread('beat6.wav');
x = x(:,1);
size(x)
x = downsample(x, 100);
plot(x)

y = abs(x) > 0.1;
indices = 1:numel(y);
event_indices = indices(y);

% Distribution of 1st order interarrivals.
rand_event_indices = indices(rand(numel(indices),1) < 0.05);
for k = 1:1000
  [intarr_1, intarr_2] = intarrkm(event_indices, k, k);
  [intarr_1_r, intarr_2_r] = intarrkm(rand_event_indices, k, k);
  subplot(121)
  scatter(intarr_1, intarr_2, 'k', 'filled', 'SizeData', 5);
  subplot(122)
  scatter(intarr_1_r, intarr_2_r, 'r', 'filled', 'SizeData', 5);
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
