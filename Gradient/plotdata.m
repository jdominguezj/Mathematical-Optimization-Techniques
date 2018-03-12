function plotdata(pathdata,funcvalue,msg)

x = pathdata(:,1);
y = pathdata(:,2);
plot(x,y,'-*')
metric_string = cell(1,length(x));
for i = 1 : length(x)
    metric_string{i} = sprintf('%2.2f',funcvalue(i));
end
text(x,y,metric_string,'Color','r',...
    'FontSize',10,'FontWeight','bold');
% if nargin == 2
%     text(x(end)+0.005,y(end)+0.005,'min','Color','b',...
%         'FontSize',10,'FontWeight','bold');
% else
%     text(x(end)+0.005,y(end)+0.005,msg,'Color','b',...
%         'FontSize',10,'FontWeight','bold');
%end


