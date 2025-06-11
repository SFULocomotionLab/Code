function figurefyTalk(s)
% function figurefyTalk
% we assume 18font for the axes, and 25 font for the axis labels.
% set(gcf,'units','centimeters','position',[0,0,14,14]');
if nargin <1
    s=1;
end;
set(gca,'fontsize',16)
set(gcf,'color','w')
set(gcf,'DefaultLineLineWidth',2)
xl = get(gca,'xlabel');
yl = get(gca,'ylabel');
xlabel(xl.String,'fontsize',16);
ylabel(yl.String,'fontsize',16);
% axis square
box off;