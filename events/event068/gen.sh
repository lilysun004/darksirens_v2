lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 31.195195195195193 --fixed-mass2 69.35119119119119 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1019148675.1896217 \
--gps-end-time 1019155875.1896217 \
--d-distr volume \
--min-distance 1115.4368558565345e3 --max-distance 1115.4568558565345e3 \
--l-distr fixed --longitude 114.16638946533203 --latitude 84.64362335205078 --i-distr uniform \
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
