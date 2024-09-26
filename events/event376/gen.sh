lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 6.654334334334335 --fixed-mass2 80.19287287287288 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1001953488.1285464 \
--gps-end-time 1001960688.1285464 \
--d-distr volume \
--min-distance 1067.1950978483053e3 --max-distance 1067.2150978483053e3 \
--l-distr fixed --longitude -163.5835723876953 --latitude -3.1039321422576904 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml
