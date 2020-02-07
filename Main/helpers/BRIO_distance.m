function BRIO_distance(result,summary,st)


result = struct2table(result);
result = sortrows(result, 'distance');
result = table2struct( result);

colors=[];

%delete if projection energy less than 10^-2
%
result(log10([result.projection_energy_normalized])<-2)=[];

for qqq=1:numel(result)
    
    colors=vertcat(colors, hex2rgb(result(qqq).hex));
    
end

y=log10([result.projection_energy_normalized ]);
x=[result.distance]/10;%�m


figure('Position',[      2311          47         576         945]);

sss=scatter(x,y,20,colors,'filled','MarkerEdgeColor' ,'none')


xlabel('Distance (�m)')
ylabel('log(Projection energy)')
makepretty(1)

hold on

%
% %add regression general
%
% p = polyfit(x,y,2);
% y1 = polyval(p,x);
% plot(x,y1,'LineWidth',2,'Color',[0 0 0])
%




order=[695 703 623 1129 313 1065 512];


% all main structures egression
n=1;
for qqq=order
    
    idx=([result.consolidated_structure_id_general]==qqq);
    
    p = polyfit(x(idx),y(idx),2);
    y1 = polyval(p,x(idx));
    
    ind=[summary{:,6}]==qqq;
    color=summary{ind,7};
    
    ppp(n)= plot(x(idx),y1,'LineWidth',4,'Color',hex2rgb(color));
    
    names{n}=char(st.safe_name([st.id]==qqq));
    
    
    n=n+1;
end
leg=legend(ppp);

leg.String=names;
leg.Box='Off';


xticks([0:200:1000])
yticks([-10:2:10])



