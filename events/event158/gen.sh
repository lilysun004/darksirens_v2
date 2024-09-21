lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 23.21101101101101 --fixed-mass2 55.98818818818819 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1009414012.8978654 \
--gps-end-time 1009421212.8978654 \
--d-distr volume \
--min-distance 1961.9914649302877e3 --max-distance 1962.0114649302877e3 \
--l-distr fixed --longitude 8.441086769104004 --latitude -24.89565658569336 --i-distr uniform \
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
