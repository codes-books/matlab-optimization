function  wc=ysw(data,pre)
nysw=size(data);
m1=0;m2=0;m3=0;m4=0;m5=0;
m11=0;m22=0;m33=0;m44=0;m55=0;
m111=0;m222=0;m333=0;m444=0;m555=0;
m1111=0;m2222=0;m3333=0;m4444=0;m5555=0;
m11111=0;m22222=0;m33333=0;m44444=0;m55555=0;
m111111=0;m222222=0;m333333=0;m444444=0;m555555=0;
for i=1:nysw(1,1)
%     if pre(i,1)~=0
        if data(i,5)>=0&&data(i,5)<=2&&data(i,4)>=0&&data(i,4)<=4
            m1=m1+1;
            By(1,1)=m1;
        end
         if data(i,5)>2&&data(i,5)<=20&&data(i,4)>=0&&data(i,4)<=4
            m2=m2+1;
            By(1,2)=m2;
        end
         if data(i,5)>20&&data(i,5)<=40&&data(i,4)>=0&&data(i,4)<=4
            m3=m3+1;
            By(1,3)=m3;
         end
          if data(i,5)>40&&data(i,5)<=60&&data(i,4)>=0&&data(i,4)<=4
            m4=m4+1;
            By(1,4)=m4;
          end
           if data(i,5)>60&&data(i,4)>=0&&data(i,4)<=4
            m5=m5+1;
            By(1,5)=m5;
           end
           %% 第二行
         if data(i,5)>=0&&data(i,5)<=2&&data(i,4)>4&&data(i,4)<=8
            m11=m11+1;
            By(2,1)=m11;
        end
         if data(i,5)>2&&data(i,5)<=20&&data(i,4)>4&&data(i,4)<=8
            m22=m22+1;
            By(2,2)=m22;
        end
         if data(i,5)>20&&data(i,5)<=40&&data(i,4)>4&&data(i,4)<=8
            m33=m33+1;
            By(2,3)=m33;
         end
          if data(i,5)>40&&data(i,5)<=60&&data(i,4)>4&&data(i,4)<=8
            m44=m44+1;
            By(2,4)=m44;
          end
           if data(i,5)>60&&data(i,4)>4&&data(i,4)<=8
            m55=m55+1;
            By(2,5)=m55;
           end  
           %% 第三行
         if data(i,5)>=0&&data(i,5)<=2&&data(i,4)>8&&data(i,4)<=12
            m111=m111+1;
            By(3,1)=m111;
        end
         if data(i,5)>2&&data(i,5)<=20&&data(i,4)>8&&data(i,4)<=12
            m222=m222+1;
            By(3,2)=m222;
        end
         if data(i,5)>20&&data(i,5)<=40&&data(i,4)>8&&data(i,4)<=12
            m333=m333+1;
            By(3,3)=m333;
         end
          if data(i,5)>40&&data(i,5)<=60&&data(i,4)>8&&data(i,4)<=12
            m444=m444+1;
            By(3,4)=m444;
          end
           if data(i,5)>60&&data(i,4)>8&&data(i,4)<=12
            m555=m555+1;
            By(3,5)=m555;
           end   
          %% 第四行
          if data(i,5)>=0&&data(i,5)<=2&&data(i,4)>12&&data(i,4)<=16
            m1111=m1111+1;
            By(4,1)=m1111;
        end
         if data(i,5)>2&&data(i,5)<=20&&data(i,4)>12&&data(i,4)<=16
            m2222=m2222+1;
            By(4,2)=m2222;
        end
         if data(i,5)>20&&data(i,5)<=40&&data(i,4)>12&&data(i,4)<=16
            m3333=m3333+1;
            By(4,3)=m3333;
         end
          if data(i,5)>40&&data(i,5)<=60&&data(i,4)>12&&data(i,4)<=16
            m4444=m4444+1;
            By(4,4)=m4444;
          end
           if data(i,5)>60&&data(i,4)>12&&data(i,4)<=16
            m5555=m5555+1;
            By(4,5)=m5555;
           end            
        %% 第五行
          if data(i,5)>=0&&data(i,5)<=2&&data(i,4)>16&&data(i,4)<=20
            m11111=m11111+1;
            By(5,1)=m11111;
        end
         if data(i,5)>2&&data(i,5)<=20&&data(i,4)>16&&data(i,4)<=20
            m22222=m22222+1;
            By(5,2)=m22222;
        end
         if data(i,5)>20&&data(i,5)<=40&&data(i,4)>16&&data(i,4)<=20
            m33333=m33333+1;
            By(5,3)=m33333;
         end
          if data(i,5)>40&&data(i,5)<=60&&data(i,4)>16&&data(i,4)<=20
            m44444=m44444+1;
            By(5,4)=m44444;
          end
           if data(i,5)>60&&data(i,4)>16&&data(i,4)<=20
            m55555=m55555+1;
            By(5,5)=m55555;
           end      
           %% 第六行
          if data(i,5)>=0&&data(i,5)<=2&&data(i,4)>20&&data(i,4)<=24
            m111111=m111111+1;
            By(6,1)=m111111;
        end
         if data(i,5)>2&&data(i,5)<=20&&data(i,4)>20&&data(i,4)<=24
            m222222=m222222+1;
            By(6,2)=m222222;
        end
         if data(i,5)>20&&data(i,5)<=40&&data(i,4)>20&&data(i,4)<=24
            m333333=m333333+1;
            By(6,3)=m333333;
         end
          if data(i,5)>40&&data(i,5)<=60&&data(i,4)>20&&data(i,4)<=24
            m444444=m444444+1;
            By(6,4)=m444444;
          end
           if data(i,5)>60&&data(i,4)>20&&data(i,4)<=24
            m555555=m555555+1;
            By(6,5)=m555555;
           end              
        
%     end
end
wc=By;