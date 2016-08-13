List = ls(pwd);
Root = pwd;
color = [1 0 0;0 1 0;0 0 1;0 1 1;0 0 0];
colorcount = 0;
for f = [3,4,5,6,7,8]
    colorcount = colorcount + 1;
    cd(List(f,:));
    load('rawEyeVelocity_left_data.mat')
    load('rawEyeVelocity_right_data.mat')
    vmean = mean(nanmean([-vl(:,1100:1200);vr(:,1100:1200)],1));
    vmean_l = mean(nanmean(-vl(:,1100:1200),1));
    vmean_r = mean(nanmean(vr(:,1100:1200),1));
    eval(['vmean_',num2str(f),'=vmean;']);
    eval(['vmeanL_',num2str(f),'=vmean_l;']);
    eval(['vmeanR_',num2str(f),'=vmean_r;']);
    
    clear vmean
%     plot(nanmean(vl,1),'Color',color(colorcount,:),'LineWidth',2);hold on
%     plot(nanmean(vr,1),'Color',color(colorcount,:),'LineWidth',2);hold on
    clear vl vr
    cd(Root)
end
grid minor;xlabel('time (ms)');ylabel('velocity (degree/s)')

figure;plot([1:6],[vmean_alary,vmean_champoux,vmean_cloutier,vmean_donaldson,vmean_heureux,vmean_poutachidis],'ro--')
set(gca,'XTick',[1:6],'xLim',[0 7]);xlabel('Patients');ylabel('ss velocity (degree/s)');grid on

Tvgs_alary = reshape(Tvgs_alary,100,1)-1000; Tvgs_alary_mean = nanmean(Tvgs_alary);
Tvgs_champoux = reshape(Tvgs_champoux,100,1)-1000; Tvgs_champoux_mean = nanmean(Tvgs_champoux);
Tvgs_cloutier = reshape(Tvgs_cloutier,120,1)-1000; Tvgs_cloutier_mean = nanmean(Tvgs_cloutier);
Tvgs_donaldson = reshape(Tvgs_donaldson,100,1)-1000; Tvgs_donaldson_mean = nanmean(Tvgs_donaldson);
Tvgs_heureux = reshape(Tvgs_heureux,120,1)-1000; Tvgs_heuruex_mean = nanmean(Tvgs_heureux);
Tvgs_poutachidis = reshape(Tvgs_poutachidis,120,1)-1000; Tvgs_poutachidis_mean = nanmean(Tvgs_poutachidis);

figure;plot(ones(100,1),Tvgs_alary(:,:),'k.');hold on;
plot(2*ones(100,1),Tvgs_champoux(:,:),'k.');hold on;
plot(3*ones(120,1),Tvgs_cloutier(:,:),'k.');hold on;
plot(4*ones(100,1),Tvgs_donaldson(:,:),'k.');hold on;
plot(5*ones(120,1),Tvgs_heureux(:,:),'k.');hold on;
plot(6*ones(120,1),Tvgs_poutachidis(:,:),'k.');hold on;
plot([1:6],[Tvgs_alary_mean,Tvgs_champoux_mean,Tvgs_cloutier_mean,Tvgs_donaldson_mean,Tvgs_heuruex_mean,Tvgs_poutachidis_mean],'rx-')
set(gca,'XTick',[1:6],'xLim',[0 7]);xlabel('Patients');ylabel('VGS reaction time (ms)');grid on