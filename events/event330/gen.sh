lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 5.477717717717718 --fixed-mass2 36.321881881881886 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026576258.81797 \
--gps-end-time 1026583458.81797 \
--d-distr volume \
--min-distance 1263.6742462691154e3 --max-distance 1263.6942462691154e3 \
--l-distr fixed --longitude 54.22592544555664 --latitude 14.153521537780762 --i-distr uniform \
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
