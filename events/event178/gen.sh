lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 5.729849849849851 --fixed-mass2 19.344984984984983 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1005433606.6554804 \
--gps-end-time 1005440806.6554804 \
--d-distr volume \
--min-distance 978.9213903415048e3 --max-distance 978.9413903415048e3 \
--l-distr fixed --longitude -65.1719970703125 --latitude 4.2852888107299805 --i-distr uniform \
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
