execute 'base_packages' do
        command 'yum -v -d 6 -y groupinstall Core'
end
