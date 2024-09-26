lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 40.86026026026026 --fixed-mass2 81.62162162162163 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1030966675.9160163 \
--gps-end-time 1030973875.9160163 \
--d-distr volume \
--min-distance 2565.5284841657754e3 --max-distance 2565.548484165776e3 \
--l-distr fixed --longitude -72.15496826171875 --latitude -49.03493118286133 --i-distr uniform \
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
