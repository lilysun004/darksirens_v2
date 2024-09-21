lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 71.36824824824825 --fixed-mass2 65.31707707707707 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1011358436.6548856 \
--gps-end-time 1011365636.6548856 \
--d-distr volume \
--min-distance 2295.7311350484524e3 --max-distance 2295.751135048453e3 \
--l-distr fixed --longitude 41.83291244506836 --latitude 15.369072914123535 --i-distr uniform \
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
