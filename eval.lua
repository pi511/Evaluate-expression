function Eval(ifade)
	local i,j
--print("Hesaplanacak İşlem=",ifade)
	i=1
	while (i<table.getn(ifade)) do
		if ( ifade[i]=="(" ) then 
			j=i+1
			p=1
			while(j<table.getn(ifade)) do
				if ( ifade[j]=="(" ) then p=p+1 end
				if (ifade[j]==")") then
					p=p-1
					if (p==0) then break end
				end
				j=j+1 
			end
			ifade[i]=Eval({table.unpack(ifade,i+1,j-1)}) 
			for y=1,j-i do table.remove(ifade,i+1) end
		else
			i=i+1
		end
	end
--print("parantezden sonra",ifade)
	p={"¹²³","n","u","/xmb","+-"} -- n=negatif, u=^, m=mod, b=kalansızBölüm
	s={"L"  ,"R","D","D"   ,"D" } --L sayı solda, R sayı sağda, D sayı çift tarafta
	sonuc="!gen"
for pi=1,table.getn(p) do 	
	i=1
	while (i<=table.getn(ifade)) do
		c=ifade[i]
		if (c=="!" or c=="(") then return "!par" end
		if (c==nil) then return "!uni" end
		sonuc=tonumber(c)
		ff1,ff2=string.find(p[pi],c)
--print("harf=",c,"öncelik=",pi,"p[pi]=",p[pi],"i=",i,"işaretmi=",a)
		if (ff1~=nil) then
			n1=tonumber(ifade[i-1])
			n2=tonumber(ifade[i+1])
			if (s[pi]=="D" and n1==nil) then if (c=="+" or c=="-") then else return "!op1" end end
			if (s[pi]=="D" and n2==nil) then return "!op2" end		
			if (s[pi]=="L" and n1==nil) then return "!op1" end		
			if (s[pi]=="R" and n2==nil) then return "!op2" end		
			if (c=="¹") then sonuc=n1 end
			if (c=="²") then sonuc=n1*n1 end
			if (c=="³") then sonuc=n1*n1*n1 end
			if (c=="n") then sonuc=n2*(-1) end
			if (c=="u") then sonuc=n1^n2 end
			if (c=="x") then sonuc=n1*n2 end
			if (c=="/") then if (n2~=0) then sonuc=n1/n2 else return "!div" end end
			if (c=="+") then if (n1~=nil ) then sonuc=n1+n2 else sonuc=n2;s[pi]="R" end end
			if (c=="-") then if (n1~=nil) then sonuc=n1-n2 else sonuc=(-1)*n2;s[pi]="R" end end
			if (c=="m") then sonuc=n1%n2 end
			if (c=="b") then if (n2~=0) then sonuc=(n1-(n1%n2))/n2 else return "!biv" end end
--print("değişmeden önce ifade",ifade,"sonuç=",sonuc)			
			ifade[i]=sonuc			
			if (s[pi]=="L") then table.remove(ifade,i-1) end
			if (s[pi]=="R") then table.remove(ifade,i+1) end
			if (s[pi]=="D") then table.remove(ifade,i-1);table.remove(ifade,i) end
--print("item=",i,"pi=",pi,"s[pi]=",s[pi],"işlem:",n1,c,n2,"sonuç=",sonuc,ifade)
		else
			i=i+1
		end
--print("sonuç=",sonuc)
	end
end
	return sonuc
end

function Evals(s)
	ifade={}
	i=1;t=1;rakam=false;onceki=false
	while (i<=string.len(s)) do
		c=string.sub(s,i,i)
		b=string.byte(c)
		if (b>=48 and b<=57) then rakam=true else rakam=false end
		if (rakam and onceki) then t=t-1 else ifade[t]="" end
		ifade[t]=ifade[t] .. c
		i=i+1;t=t+1
		onceki=rakam
	end
--print(s,ifade)	
	return Eval(ifade)
end	

--örnekler
print("--------------------------------------------")
print("Sonuç1=",Evals("3u(7-(3-1)x2)x3+2-5")) 											-- = 78
a={5,"x","(","1","+",5,"m",3,")"} 															-- = 15
print("Sonuç2=",Eval(a))
a={"n","1","x","(",511,"b",8,")","x",8,"+",511,"m",8}									-- = -497
print("Sonuç3=",Eval(a))
a={"(","n",3,")","³"}																			-- = -27
print("Sonuç4=",Eval(a))
a={"(","(","n","(","(","(",5,"x",2,")","+",1,")","m",3,")","³",")","²",")"}	-- = 64
print("Sonuç5=",Eval(a))
a="5+((1))"																							-- = 6
print("Sonuç6=",Evals(a))
a="5+((())"   																						-- anlamsız
print("Sonuç7=",Evals(a))
a="5/0"   																							-- anlamsız
print("Sonuç8=",Evals(a))
a="5m0"   																							-- anlamsız
print("Sonuç9=",Evals(a))
a="5b0"   																							-- anlamsız
print("Sonuç10=",Evals(a))
a="³"   																								-- anlamsız
print("Sonuç11=",Evals(a))
a="n"   																								-- anlamsız
print("Sonuç12=",Evals(a))
a="+5"   																							-- 5
print("Sonuç13=",Evals(a))
a="-5"   																							-- -5
print("Sonuç14=",Evals(a))
a={5,"²"}   																						-- 25
print("Sonuç15=",Eval(a))
a={"²"}   																							-- anlamsız
print("Sonuç16=",Eval(a))
