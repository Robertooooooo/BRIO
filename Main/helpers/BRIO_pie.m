function BRIO_pie(result)


 result = struct2table(result);
 result = sortrows(result, 'projection_energy');
 result = table2struct( result);

colors=[];
for qqq=1:numel(result)

colors=vertcat(colors, hex2rgb(result(qqq).hex));

end

name=[];
for qqq=1:numel(result)

name{qqq}=result(qqq).name;

end


figure
ppp=pie([result.projection_energy],ones(numel(result),1),name)
colormap(colors)



for qqq = 2:2:numel(result)*2
ppp(qqq).Color = colors(qqq/2,:);
ppp(qqq).FontWeight='Bold';
end

makepretty(1)