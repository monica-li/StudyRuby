require 'json'

json_file_path="tt.json"

jsl=[]
File.open(json_file_path, 'r:utf-8') do |file|
 file.each do |line|
  jsl.push(line)
 end
end

#puts jsons.length
chengqu=""

jsl.each do |j|
  diqu=JSON.parse(j)
  diqu.each do |k,v|
#   puts k
   if k == "data" 
     v.each do |dk,dv|
       dv.each do |dkk,dkv|
         if dkk == "name"
            puts dkv
            chengqu = dkv
         end
       end
       if dk == "hourly"
         dv.each do |hdk,hdv|
           puts hdk
         end
       end
     end
   end
  end
end


