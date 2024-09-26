lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 39.431511511511516 --fixed-mass2 58.761641641641646 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1017033576.4028072 \
--gps-end-time 1017040776.4028072 \
--d-distr volume \
--min-distance 2564.6856376605424e3 --max-distance 2564.705637660543e3 \
--l-distr fixed --longitude 156.25833129882812 --latitude -16.83000373840332 --i-distr uniform \
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
