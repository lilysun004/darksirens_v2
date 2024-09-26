lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 14.302342342342342 --fixed-mass2 50.273193193193194 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1011087441.2327766 \
--gps-end-time 1011094641.2327766 \
--d-distr volume \
--min-distance 1859.6774617531312e3 --max-distance 1859.6974617531312e3 \
--l-distr fixed --longitude -67.79556274414062 --latitude 64.31855773925781 --i-distr uniform \
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
