lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 34.38886886886887 --fixed-mass2 24.303583583583585 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002696221.1881819 \
--gps-end-time 1002703421.1881819 \
--d-distr volume \
--min-distance 527.6362495827785e3 --max-distance 527.6562495827785e3 \
--l-distr fixed --longitude 34.9275016784668 --latitude -58.71674346923828 --i-distr uniform \
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
