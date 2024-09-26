lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 22.958878878878878 --fixed-mass2 52.20620620620621 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1010409473.220677 \
--gps-end-time 1010416673.220677 \
--d-distr volume \
--min-distance 1718.2683688037127e3 --max-distance 1718.2883688037127e3 \
--l-distr fixed --longitude 132.78887939453125 --latitude 15.547076225280762 --i-distr uniform \
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
