execute 'update_yum_caches' do
        command 'yum -v -d 6 -y update'
end
