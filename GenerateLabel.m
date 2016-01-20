function [ label ] = GenerateLabel( name, data )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

labeltmp='';
for i=1:length(data)
    if data(i)~=0
       %labeltmp=strcat(labeltmp,' ',name,'_',num2str(i-10),'=',num2str(data(i)),' ');
       labeltmp=[labeltmp name '_{' num2str(i-10) '}=' num2str(data(i)) ' '];
    end
    
end

label=labeltmp;


end

