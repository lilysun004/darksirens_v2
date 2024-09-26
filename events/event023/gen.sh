lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 27.41321321321321 --fixed-mass2 53.88708708708709 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1024372951.5641863 \
--gps-end-time 1024380151.5641863 \
--d-distr volume \
--min-distance 2300.7938347826725e3 --max-distance 2300.813834782673e3 \
--l-distr fixed --longitude -44.556854248046875 --latitude 15.575224876403809 --i-distr uniform \
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
