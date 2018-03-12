function Graph(POSITIONS)
%%
x = POSITIONS(:,1);
y = POSITIONS(:,2);
plot(x,y,'.')
metric_string = cell(1,length(x));
for i = 1 : length(x)
    metric_string{i} = sprintf('%2.2f',i);
end
text(x,y,metric_string,'Color','r',...
    'FontSize',10,'FontWeight','bold');
end

