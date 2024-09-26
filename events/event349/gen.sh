lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 29.934534534534535 --fixed-mass2 29.598358358358357 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1015347494.3938987 \
--gps-end-time 1015354694.3938987 \
--d-distr volume \
--min-distance 1997.159317055735e3 --max-distance 1997.179317055735e3 \
--l-distr fixed --longitude 8.786409378051758 --latitude 50.71428680419922 --i-distr uniform \
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
