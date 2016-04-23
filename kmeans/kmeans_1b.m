function [clusters, means] = kmeans_1b( k, target_file, ep )
    data_mat = load('data_mat.txt');
    target_str = fileread(target_file);
    target_str = strsplit(target_str, '\n');
    target_mat = zeros(size(data_mat,1),1);
    for index0 = 2:size(target_str,2)-1
        tmp = strsplit(target_str{index0},' ');
        target_mat(index0-1,1) = str2double(tmp(1,2));
    end
    clusters = zeros(size(target_mat,1),1);
    means_ind = fix(rand(1,k)*size(data_mat,1));
    disp(means_ind);
    means = zeros(k, size(data_mat,2));
    for index0 = 1:k
        means(index0,:) = data_mat(means_ind(1,index0),:);
    end
    error = realmax;
    iter = 0;
    accuracy = zeros(1,k);
%     cluster_nodes = {};
    goodness = zeros(1,30);
    while(iter < 30)
        cluster_nodes = {};
        for index0=1:k
            cluster_nodes{index0} = [];
        end
        for index0 = 1:size(data_mat,1)
            min_cluster = realmax;
            min_ind=0;
            for index1 = 1:k
                cl = norm(data_mat(index0,:)-means(index1,:));
                cl = cl^2;
                if(cl < min_cluster)
                    min_cluster = cl;
                    min_ind = index1;
                end
            end
            clusters(index0,1) = min_ind;
            cluster_nodes{min_ind} = [cluster_nodes{min_ind} index0];
        end
        for index1 = 1:k
            num = zeros(1,size(data_mat,2));
            den = 0;
            for index0 = 1:size(data_mat,1)
                if(clusters(index0,1) == index1)
                    num = num + data_mat(index0,:);
                    den = den + 1;
                end
            end
            means(index1,:) = num/den;
        end
        for index1 = 1:k
%             max_digit = 0;
            n_digits = zeros(1,7);
            for index0 = 1:size(cluster_nodes{index1},2)
                digit = target_mat(cluster_nodes{index1}(1,index0),1);
                n_digits(1,digit) = n_digits(1,digit) + 1;
            end
            accuracy(1,index1) = max(n_digits)/sum(n_digits);
        end
        tmp_error = 0;
        for index0 = 1:size(data_mat,1)
            tmp_error = tmp_error + (norm(data_mat(index0,:)-means(clusters(index0,1),:)))^2;
        end
        goodness(1,iter+1) = tmp_error;
        if(abs(tmp_error-error) < ep)
            error = tmp_error;
            break;
        end
        error = tmp_error;
%         disp(error);
        iter = iter+1;
    end
    disp(accuracy);
    if(iter == 30)
        disp('iterations complete: ');
        disp(error);
    end
    xx = 1:30;
    plot(xx,goodness,'r-');
end

