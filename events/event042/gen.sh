lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 56.91267267267268 --fixed-mass2 18.25241241241241 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1029193204.2622544 \
--gps-end-time 1029200404.2622544 \
--d-distr volume \
--min-distance 1793.5002032477014e3 --max-distance 1793.5202032477014e3 \
--l-distr fixed --longitude -72.2711181640625 --latitude 15.632012367248535 --i-distr uniform \
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
