function rhythm

x = wavread('beat6.wav');
x = x(:,1);
x = downsample(x, 50);
plot(x)

y = abs(x) > 0.1;
indices = 1:numel(y);
event_indices = indices(y);

% Distribution of 1st order interarrivals.
rand_event_indices = indices(rand(numel(indices),1) < 0.05);
% for k = 1:1000
%   [intarr_1, intarr_2] = intarrkm(event_indices, k, k);
%   [intarr_1_r, intarr_2_r] = intarrkm(rand_event_indices, k, k);
%   subplot(121)
%   scatter(intarr_1, intarr_2, 'k', 'filled', 'SizeData', 5);
%   subplot(122)
%   scatter(intarr_1_r, intarr_2_r, 'r', 'filled', 'SizeData', 5);
%   % hist(intarrk(event_indices, k), 80)
%   title(k)
%   pause(0.1)
% end

numel(y)
w = 10000;
indices_w = 1:w;
rand_y = rand(size(y)) < 0.05;
for i = 1:100:(numel(y) - w)
  y_w = y(i:i+w-1);
  rand_y_w = rand_y(i:i+w-1);
  event_indices_w = indices_w(y_w);
  rand_event_indices_w = indices_w(rand_y_w);
  [intarr_1, intarr_2] = intarrkm(event_indices_w, 6, 6);
  [intarr_1_r, intarr_2_r] = intarrkm(rand_event_indices_w, 6, 6);
 
  subplot(121)
  A = points2image(intarr_1, intarr_2);
  s = min(size(A));
  A = imresize(A, 200/s);
  A = conv2(A, fspecial('gaussian', 20, 5), 'same');
  imagesc(A)
  %axis equal
  %scatter(intarr_1, intarr_2, 'k', 'filled', 'SizeData', 5);
  
  subplot(122)
  A = points2image(intarr_1_r, intarr_2_r);
  s = min(size(A));
  A = imresize(A, 200/s);
  A = conv2(A, fspecial('gaussian', 20, 5), 'same');
  imagesc(A)
  %axis equal
  %scatter(intarr_1_r, intarr_2_r, 'r', 'filled', 'SizeData', 5);
  title(i)
  pause(0.01);
end

function A = points2image(r, c)
r = ceil(r);
c = ceil(c);
A = zeros(max(r), max(c));
linind = sub2ind(size(A), r, c);
A(linind) = 1;

function intarr = intarrk(s, k)
intarr = s(k+1:end) - s(1:end - k);
intarr(intarr < 100) = [];

function [intarrk,intarrm] = intarrkm(s, k, m)
intarrk = s(k+1:end-m) - s(1:end-m-k);
intarrm = s(k+m+1:end) - s(k+1:end-m);
bad_ind = (intarrk < 50 | intarrm < 50);
intarrk(bad_ind) = [];
intarrm(bad_ind) = [];
