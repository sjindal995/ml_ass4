function [parameters ,test_logli] = em_a( train_file, test_file )
        train_struct = importdata(train_file);
        labels = train_struct.colheaders;
        train_data = train_struct.data;
        parameters = {};
        parameters{1} = zeros(1,2);
        parameters{2} = zeros(2,2);
        parameters{3} = zeros(2,2);
        parameters{4} = zeros(2,2);
        parameters{5} = zeros(4,2);
        total = {};
        total{1} = zeros(1,1);
        total{2} = zeros(2,1);
        total{3} = zeros(2,1);
        total{4} = zeros(2,1);
        total{5} = zeros(4,1);
        for index0 = 1:size(train_data,1)
            h = train_data(index0,1);
            b = train_data(index0,2);
            l = train_data(index0,3);
            x = train_data(index0,4);
            f = train_data(index0,5);
            parameters{1}(1,2) = parameters{1}(1,2) + h;
            parameters{2}(h+1,2) = parameters{2}(h+1,2) + b;
            parameters{3}(h+1,2) = parameters{3}(h+1,2) + l;
            parameters{4}(l+1,2) = parameters{4}(l+1,2) + x;
            parameters{5}(2*b + l +1, 2) = parameters{5}(2*b + l +1, 2) + f;
            total{1}(1,1) = total{1}(1,1)+1;
            total{2}(h+1,1) = total{2}(h+1,1) + 1;
            total{3}(h+1,1) = total{3}(h+1,1) + 1;
            total{4}(l+1,1) = total{4}(l+1,1) + 1;
            total{5}(2*b+l+1,1) = total{5}(2*b+l+1,1) + 1;
        end
        parameters{1}(1,2) = parameters{1}(1,2)/total{1}(1,1);
        parameters{1}(1,1) = 1 - parameters{1}(1,2);
        for index0 = 2:4
            for index1 = 1:2
                parameters{index0}(index1,2) = parameters{index0}(index1,2)/total{index0}(index1,1);
                parameters{index0}(index1,1) = 1 - parameters{index0}(index1,2);
            end
        end
%         parameters{3}(1,2) = parameters{3}(1,2)/total{3}(1,1);
%         parameters{3}(2,2) = parameters{3}(2,2)/total{3}(2,1);
%         parameters{4}(1,2) = parameters{4}(1,2)/total{4}(1,1);
%         parameters{4}(2,2) = parameters{4}(2,2)/total{4}(2,1);
        for index0 = 1:4
            parameters{5}(index0,2) = parameters{5}(index0,2)/total{5}(index0,1);
            parameters{5}(index0,1) = 1 - parameters{5}(index0,2);
        end
        test_str = importdata(test_file);
        test_data = test_str.data;
        test_logli = 0;
        for index0 = 1:size(test_data,1)
            h = test_data(index0,1);
            b = test_data(index0,2);
            l = test_data(index0,3);
            x = test_data(index0,4);
            f = test_data(index0,5);
            prob = parameters{5}(2*b+l+1,f+1)*parameters{4}(l+1,x+1)*parameters{3}(h+1,l+1)*parameters{2}(h+1,b+1)*parameters{1}(1,h+1);
            disp(prob);
            test_logli = test_logli + log(prob);
        end
end

